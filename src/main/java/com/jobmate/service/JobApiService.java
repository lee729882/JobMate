package com.jobmate.service;

import com.jobmate.domain.JobPosting;
import com.jobmate.domain.MemberPreference;
import org.springframework.stereotype.Service;
import org.w3c.dom.*;
import javax.xml.parsers.*;
import java.io.InputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

@Service
public class JobApiService {

    private static final String BASE_URL = "https://www.work24.go.kr/cm/openApi/call/wk/callOpenApiSvcInfo210L01.do";
    private static final String SERVICE_KEY = "c4f59a27-27b9-47d5-a5f5-a51c9cd47a13";
    public List<JobPosting> fetchJobs(MemberPreference pref) {
        List<JobPosting> jobs = new ArrayList<>();

        try {
            String occupation = (pref.getOccCodesCsv() != null) ? pref.getOccCodesCsv() : "024";
            String region = (pref.getRegionCodesCsv() != null) ? pref.getRegionCodesCsv() : "11";
            String keyword = (pref.getKeyword() != null && !pref.getKeyword().isEmpty()) ? pref.getKeyword() : "개발자";

            StringBuilder sb = new StringBuilder(BASE_URL);
            sb.append("?authKey=").append(SERVICE_KEY);
            sb.append("&callTp=L");
            sb.append("&returnType=XML");
            sb.append("&startPage=1");
            sb.append("&display=10");
            sb.append("&keyword=").append(URLEncoder.encode(keyword, "UTF-8"));
            sb.append("&region=").append(region);
            sb.append("&occupation=").append(occupation);

            System.out.println("📡 [DEBUG] 요청 URL: " + sb);

            URL url = new URL(sb.toString());
            InputStream stream = url.openStream();

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(stream);
            doc.getDocumentElement().normalize();

            NodeList wantedList = doc.getElementsByTagName("wanted");
            System.out.println("📊 [DEBUG] 가져온 공고 수: " + wantedList.getLength());

            for (int i = 0; i < wantedList.getLength(); i++) {
                Element el = (Element) wantedList.item(i);
                JobPosting job = new JobPosting();

                job.setTitle(getTag(el, "title"));
                job.setCompany(getTag(el, "company"));
                job.setRegionName(getTag(el, "region"));
                job.setEmploymentType(getTag(el, "salTpNm"));
                job.setCareerLevel(getTag(el, "career"));
                job.setSalaryText(getTag(el, "sal"));
                job.setPostedAt(getTag(el, "regDt"));
                job.setDeadlineAt(getTag(el, "closeDt"));
                job.setDetailUrl(getTag(el, "wantedInfoUrl"));
                job.setSource("고용24");

                jobs.add(job);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return jobs;
    }

    private String getTag(Element element, String tagName) {
        NodeList nodeList = element.getElementsByTagName(tagName);
        if (nodeList.getLength() == 0) return "";
        return nodeList.item(0).getTextContent().trim();
    }
}
