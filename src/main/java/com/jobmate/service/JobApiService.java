package com.jobmate.service;

import com.jobmate.domain.JobPosting;
import com.jobmate.domain.MemberPreference;
import com.jobmate.mapper.ExcelCodeMapper; // ✅ 엑셀 매핑 클래스
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
            // ✅ 기본값 세팅
            String occupationCsv = (pref.getOccCodesCsv() != null && !pref.getOccCodesCsv().isEmpty()) 
                    ? pref.getOccCodesCsv() : "JOB102";
            String regionCsv = (pref.getRegionCodesCsv() != null && !pref.getRegionCodesCsv().isEmpty()) 
                    ? pref.getRegionCodesCsv() : "11000";
            String keyword = (pref.getKeyword() != null && !pref.getKeyword().isEmpty()) 
                    ? pref.getKeyword() : "개발자";

            // 쉼표 분리
            String[] occupations = occupationCsv.split(",");
            String[] regions = regionCsv.split(",");

            // ✅ ExcelCodeMapper 초기화 (필요 시 자동 실행)
            ExcelCodeMapper.loadAllCodes();

            // 모든 조합 순회
            for (String occ : occupations) {
                String mappedOcc = ExcelCodeMapper.getOccupation(occ.trim()); // ✅ 엑셀 매핑 적용

                for (String reg : regions) {
                    String mappedReg = ExcelCodeMapper.getRegion(reg.trim()); // ✅ 엑셀 매핑 적용

                    StringBuilder sb = new StringBuilder(BASE_URL);
                    sb.append("?authKey=").append(SERVICE_KEY);
                    sb.append("&callTp=L");
                    sb.append("&returnType=XML");
                    sb.append("&startPage=1");
                    sb.append("&display=10");
                    sb.append("&keyword=").append(URLEncoder.encode(keyword, "UTF-8"));
                    sb.append("&region=").append(mappedReg);
                    sb.append("&occupation=").append(mappedOcc);

                    System.out.println("\n📡 [DEBUG] 요청 URL: " + sb);

                    // API 요청
                    URL url = new URL(sb.toString());
                    InputStream stream = url.openStream();

                    // XML 파싱
                    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                    DocumentBuilder builder = factory.newDocumentBuilder();
                    Document doc = builder.parse(stream);
                    doc.getDocumentElement().normalize();

                    NodeList wantedList = doc.getElementsByTagName("wanted");
                    System.out.println("📊 [DEBUG] 응답 공고 수 (" + mappedReg + " / " + mappedOcc + "): " + wantedList.getLength());

                    // 공고 데이터 파싱
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

                    stream.close();
                }
            }

            System.out.println("\n✅ [INFO] 총 수집된 추천 공고 수: " + jobs.size());

        } catch (Exception e) {
            System.err.println("❌ [ERROR] 고용24 API 호출 중 예외 발생:");
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
