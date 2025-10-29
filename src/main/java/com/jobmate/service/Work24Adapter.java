package com.jobmate.service;

import com.jobmate.domain.JobPosting;
import com.jobmate.domain.MemberPreference;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import org.w3c.dom.*;
import javax.xml.parsers.*;
import java.util.*;

@Service
public class Work24Adapter implements JobSourceAdapter {

    private final RestTemplate rest = new RestTemplate();

    @Override
    public String sourceName() { return "WORK24"; }

    @Override
    public List<JobPosting> fetch(MemberPreference pref, int page, int size) {
        String url = UriComponentsBuilder
                .fromHttpUrl("https://www.work24.go.kr/openapi/empInfo/getEmpInfo") // 실제 문서에 맞게 교체
                .queryParam("authKey", "YOUR_API_KEY")                               // 교체
                .queryParam("returnType", "XML")
                .queryParam("startPage", page)
                .queryParam("display", size)
                .queryParam("occupation", pref.getOccCodesCsv())
                .queryParam("region", pref.getRegionCodesCsv())
                .queryParam("employmentType", pref.getEmploymentType())
                .queryParam("searchWord", pref.getKeyword())
                .build(true).toString();

        String xml = rest.getForObject(url, String.class);
        return parse(xml);
    }

    private List<JobPosting> parse(String xml) {
        List<JobPosting> list = new ArrayList<>();
        try {
            DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
            DocumentBuilder b = f.newDocumentBuilder();
            Document doc = b.parse(new org.xml.sax.InputSource(new java.io.StringReader(xml)));
            NodeList items = doc.getElementsByTagName("item"); // 구조에 맞게 수정
            for (int i=0; i<items.getLength(); i++) {
                Element e = (Element) items.item(i);

                JobPosting p = new JobPosting();
                p.setSource(sourceName());
                p.setSourcePostingId(get(e,"wantedAuthNo")); // 예시
                p.setTitle(get(e,"title"));
                p.setCompany(get(e,"company"));
                p.setRegionName(get(e,"region"));
                p.setEmploymentType(get(e,"employmentType"));
                p.setCareerLevel(get(e,"career"));
                p.setSalaryText(get(e,"salary"));
                p.setPostedAt(get(e,"regDt"));
                p.setDeadlineAt(get(e,"closeDt"));
                p.setDetailUrl(get(e,"detailUrl"));

                list.add(p);
            }
        } catch (Exception ignore) { /* 단순: 실패 시 빈 리스트 */ }
        return list;
    }

    private static String get(Element e, String tag) {
        NodeList nl = e.getElementsByTagName(tag);
        if (nl.getLength()==0) return null;
        String t = nl.item(0).getTextContent();
        return t==null? null : t.trim();
    }
}
