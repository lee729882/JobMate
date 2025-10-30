package com.jobmate.api;

import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
public class EmploymentDetailResponse {
    private String empSeqno;
    private String empWantedTitle;
    private String empBusiNm;
    private String coClcdNm;
    private String empWantedStdt;
    private String empWantedEndt;
    private String empWantedTypeNm;
    private String empSubmitDocCont;
    private String empRcptMthdCont;
    private String empAcptPsnAnncCont;
    private String inqryCont;
    private String empJobsList;
    private String workRegionNm;
    private String empWantedCareerNm;
    private String empWantedEduNm;
    private String empWantedHomepgDetail;
    private String empWantedMobileUrl;
    private List<String> selfintroQstCont;
}
