package com.jobmate.service;

import com.jobmate.api.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.w3c.dom.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class EmploymentService {

    private final EmploymentApiClient apiClient;

    /** ✅ 공채속보 목록 */
    public List<EmploymentResponse> getEmploymentList(int page, int size) {
        String xml = apiClient.getEmploymentList(page, size);
        List<EmploymentResponse> list = new ArrayList<>();

        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)));

            NodeList nodes = doc.getElementsByTagName("dhsOpenEmpInfo");
            for (int i = 0; i < nodes.getLength(); i++) {
                Element e = (Element) nodes.item(i);
                EmploymentResponse res = new EmploymentResponse();

                res.setEmpSeqno(getTagValue(e, "empSeqno"));
                res.setEmpWantedTitle(getTagValue(e, "empWantedTitle"));
                res.setEmpBusiNm(getTagValue(e, "empBusiNm"));
                res.setCoClcdNm(getTagValue(e, "coClcdNm"));
                res.setEmpWantedTypeNm(getTagValue(e, "empWantedTypeNm"));   // ✅ 고용형태
                res.setEmpWantedEndt(getTagValue(e, "empWantedEndt"));

                // ✅ 경력구분 코드 → 텍스트 변환
                String careerCode = getTagValue(e, "empWantedCareerCd");
                res.setEmpWantedCareerNm(convertCareerCode(careerCode));

                list.add(res);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    /** ✅ 상세페이지용 */
    public EmploymentDetailResponse getEmploymentDetail(String empSeqno) {
        String xml = apiClient.getEmploymentDetail(empSeqno);
        EmploymentDetailResponse res = new EmploymentDetailResponse();

        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)));

            Element root = (Element) doc.getElementsByTagName("dhsOpenEmpInfoDetailRoot").item(0);
            if (root == null) return res;

            // ─ 기본정보 ─
            res.setEmpSeqno(getTagValue(root, "empSeqno"));
            res.setEmpWantedTitle(getTagValue(root, "empWantedTitle"));
            res.setEmpBusiNm(getTagValue(root, "empBusiNm"));
            res.setCoClcdNm(getTagValue(root, "coClcdNm"));
            res.setEmpWantedTypeNm(getTagValue(root, "empWantedTypeNm"));
            res.setEmpWantedStdt(getTagValue(root, "empWantedStdt"));
            res.setEmpWantedEndt(getTagValue(root, "empWantedEndt"));
            res.setEmpWantedHomepgDetail(getTagValue(root, "empWantedHomepgDetail"));
            res.setEmpWantedHomepg(getTagValue(root, "empWantedHomepg"));
            res.setRegLogImgNm(getTagValue(root, "regLogImgNm"));
            res.setEmpWantedMobileUrl(getTagValue(root, "empWantedMobileUrl"));

            // ─ 지원자격 ─
            res.setEmpWantedCareerNm(getTagValue(root, "empWantedCareerNm"));
            res.setEmpWantedEduNm(getTagValue(root, "empWantedEduNm"));
            res.setWorkRegionNm(getTagValue(root, "workRegionNm"));

            // ─ 모집분야 ─
            NodeList recrNodes = doc.getElementsByTagName("empRecrListInfo");
            if (recrNodes.getLength() > 0) {
                Element e = (Element) recrNodes.item(0);
                res.setEmpRecrNm(getTagValue(e, "empRecrNm"));
                res.setJobCont(getTagValue(e, "jobCont"));
                res.setSptCertEtc(getTagValue(e, "sptCertEtc"));
                res.setRecrPsncnt(getTagValue(e, "recrPsncnt"));
                res.setEmpRecrMemoCont(getTagValue(e, "empRecrMemoCont"));
            }

            // ─ 전형단계 리스트 ─
            List<SelectionStage> stages = new ArrayList<>();
            NodeList selsNodes = doc.getElementsByTagName("empSelsListInfo");
            for (int i = 0; i < selsNodes.getLength(); i++) {
                Element s = (Element) selsNodes.item(i);
                SelectionStage stage = new SelectionStage();
                stage.setSelsNm(getTagValue(s, "selsNm"));
                stage.setSelsSchdCont(getTagValue(s, "selsSchdCont"));
                stage.setSelsCont(getTagValue(s, "selsCont"));
                stage.setSelsMemoCont(getTagValue(s, "selsMemoCont"));
                stages.add(stage);
            }
            res.setSelectionList(stages);

            // ─ 기타정보 ─
            res.setEmpSubmitDocCont(getTagValue(root, "empSubmitDocCont"));
            res.setEmpRcptMthdCont(getTagValue(root, "empRcptMthdCont"));
            res.setEmpAcptPsnAnncCont(getTagValue(root, "empAcptPsnAnncCont"));
            res.setEmpnEtcCont(getTagValue(root, "empnEtcCont"));
            res.setRecrCommCont(getTagValue(root, "recrCommCont"));
            res.setInqryCont(getTagValue(root, "inqryCont"));

        } catch (Exception e) {
            e.printStackTrace();
        }

        return res;
    }

    /** ✅ 코드 → 한글 변환 */
    private String convertCareerCode(String code) {
        if (code == null || code.isEmpty()) return "-";
        switch (code) {
            case "10": return "경력무관";
            case "20": return "경력";
            case "30": return "신입";
            case "40": return "인턴";
            default: return "-";
        }
    }

    /** ✅ XML 태그 파싱 공통 메서드 */
    private String getTagValue(Element element, String tag) {
        NodeList list = element.getElementsByTagName(tag);
        if (list.getLength() == 0) return "";
        return list.item(0).getTextContent();
    }
}
