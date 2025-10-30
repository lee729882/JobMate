package com.jobmate.api;

import lombok.Data;
import java.util.List;

@Data
public class EmploymentDetailResponse {
    private String empSeqno;
    private String empWantedTitle;
    private String empBusiNm;
    private String coClcdNm;
    private String empWantedTypeNm;
    private String empWantedStdt;
    private String empWantedEndt;
    private String empWantedCareerNm;
    private String empWantedEduNm;
    private String workRegionNm;
    private String empSubmitDocCont;
    private String empRcptMthdCont;
    private String empAcptPsnAnncCont;
    private String empWantedHomepg;
    private String empWantedHomepgDetail;
    private String empWantedMobileUrl;
    private String regLogImgNm;

    // 모집분야 상세
    private String empRecrNm;
    private String jobCont;
    private String sptCertEtc;
    private String recrPsncnt;
    private String empRecrMemoCont;

    // 전형단계
    private List<SelectionStage> selectionList;

    // 기타
    private String empnEtcCont;
    private String recrCommCont;
    private String inqryCont;
}
