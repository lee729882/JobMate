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
                res.setEmpWantedEndt(getTagValue(e, "empWantedEndt"));
                list.add(res);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public EmploymentDetailResponse getEmploymentDetail(String empSeqno) {
        String xml = apiClient.getEmploymentDetail(empSeqno);
        EmploymentDetailResponse res = new EmploymentDetailResponse();

        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document doc = builder.parse(new ByteArrayInputStream(xml.getBytes(StandardCharsets.UTF_8)));

            Element root = (Element) doc.getElementsByTagName("dhsOpenEmpInfoDetailRoot").item(0);
            res.setEmpSeqno(getTagValue(root, "empSeqno"));
            res.setEmpWantedTitle(getTagValue(root, "empWantedTitle"));
            res.setEmpBusiNm(getTagValue(root, "empBusiNm"));
            res.setCoClcdNm(getTagValue(root, "coClcdNm"));
            res.setEmpWantedTypeNm(getTagValue(root, "empWantedTypeNm"));
            res.setEmpWantedStdt(getTagValue(root, "empWantedStdt"));
            res.setEmpWantedEndt(getTagValue(root, "empWantedEndt"));
            res.setEmpWantedCareerNm(getTagValue(root, "empWantedCareerNm"));
            res.setEmpWantedEduNm(getTagValue(root, "empWantedEduNm"));
            res.setWorkRegionNm(getTagValue(root, "workRegionNm"));
            res.setEmpSubmitDocCont(getTagValue(root, "empSubmitDocCont"));
            res.setEmpRcptMthdCont(getTagValue(root, "empRcptMthdCont"));
            res.setEmpAcptPsnAnncCont(getTagValue(root, "empAcptPsnAnncCont"));
            res.setEmpWantedHomepgDetail(getTagValue(root, "empWantedHomepgDetail"));
        } catch (Exception e) {
            e.printStackTrace();
        }

        return res;
    }


    private String getTagValue(Element element, String tag) {
        NodeList list = element.getElementsByTagName(tag);
        if (list.getLength() == 0) return "";
        return list.item(0).getTextContent();
    }
    
}
