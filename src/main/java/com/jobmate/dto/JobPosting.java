package com.jobmate.dto;

public class JobPosting {
    private String source;          // "WORK24" 등
    private String sourcePostingId; // 소스 고유 id
    private String title;
    private String company;
    private String regionName;
    private String employmentType;
    private String careerLevel;
    private String salaryText;
    private String postedAt;
    private String deadlineAt;
    private String detailUrl;

    // getter/setter
    public String getSource() { return source; }
    public void setSource(String source) { this.source = source; }
    public String getSourcePostingId() { return sourcePostingId; }
    public void setSourcePostingId(String sourcePostingId) { this.sourcePostingId = sourcePostingId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getCompany() { return company; }
    public void setCompany(String company) { this.company = company; }
    public String getRegionName() { return regionName; }
    public void setRegionName(String regionName) { this.regionName = regionName; }
    public String getEmploymentType() { return employmentType; }
    public void setEmploymentType(String employmentType) { this.employmentType = employmentType; }
    public String getCareerLevel() { return careerLevel; }
    public void setCareerLevel(String careerLevel) { this.careerLevel = careerLevel; }
    public String getSalaryText() { return salaryText; }
    public void setSalaryText(String salaryText) { this.salaryText = salaryText; }
    public String getPostedAt() { return postedAt; }
    public void setPostedAt(String postedAt) { this.postedAt = postedAt; }
    public String getDeadlineAt() { return deadlineAt; }
    public void setDeadlineAt(String deadlineAt) { this.deadlineAt = deadlineAt; }
    public String getDetailUrl() { return detailUrl; }
    public void setDetailUrl(String detailUrl) { this.detailUrl = detailUrl; }
}
