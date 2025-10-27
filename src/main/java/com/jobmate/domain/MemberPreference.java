package com.jobmate.domain;

public class MemberPreference {
    private Long id;
    private Long memberId;
    private String occCodesCsv;     // "134100,134200"
    private String regionCodesCsv;  // "11000,41000"
    private String employmentType;  // 정규/계약/시간제 등
    private String careerLevel;     // 신입/경력/무관 등
    private String keyword;         // 자유 키워드

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getMemberId() { return memberId; }
    public void setMemberId(Long memberId) { this.memberId = memberId; }
    public String getOccCodesCsv() { return occCodesCsv; }
    public void setOccCodesCsv(String occCodesCsv) { this.occCodesCsv = occCodesCsv; }
    public String getRegionCodesCsv() { return regionCodesCsv; }
    public void setRegionCodesCsv(String regionCodesCsv) { this.regionCodesCsv = regionCodesCsv; }
    public String getEmploymentType() { return employmentType; }
    public void setEmploymentType(String employmentType) { this.employmentType = employmentType; }
    public String getCareerLevel() { return careerLevel; }
    public void setCareerLevel(String careerLevel) { this.careerLevel = careerLevel; }
    public String getKeyword() { return keyword; }
    public void setKeyword(String keyword) { this.keyword = keyword; }
}
