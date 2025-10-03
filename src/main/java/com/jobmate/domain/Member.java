package com.jobmate.domain;

import java.util.Objects;

public class Member {
    private Long id;
    private String username;
    private String password;
    private String email;
    private String name;

    private String careerType;        // 경력 여부 (NEW/EXP/ANY)
    private String eduCode;           // 학력 (ANY/HS/AD/BA/MA/PHD)
    private Integer minSalary;        // 희망 연봉 하한(만원)

    // 다중 선택은 CSV로 저장 (예: "JOB101,JOB502")
    private String jobCodes;          // 희망 직종 코드들
    private String workRegionCodes;   // 근무지역 코드들 (시/군/구 코드)

    public Member() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCareerType() { return careerType; }
    public void setCareerType(String careerType) { this.careerType = careerType; }

    public String getEduCode() { return eduCode; }
    public void setEduCode(String eduCode) { this.eduCode = eduCode; }

    public Integer getMinSalary() { return minSalary; }
    public void setMinSalary(Integer minSalary) { this.minSalary = minSalary; }

    public String getJobCodes() { return jobCodes; }
    public void setJobCodes(String jobCodes) { this.jobCodes = jobCodes; }

    public String getWorkRegionCodes() { return workRegionCodes; }
    public void setWorkRegionCodes(String workRegionCodes) { this.workRegionCodes = workRegionCodes; }

    @Override
    public String toString() {
        return "Member{" +
                "id=" + id +
                ", username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", name='" + name + '\'' +
                ", careerType='" + careerType + '\'' +
                ", eduCode='" + eduCode + '\'' +
                ", minSalary=" + minSalary +
                ", jobCodes='" + jobCodes + '\'' +
                ", workRegionCodes='" + workRegionCodes + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Member)) return false;
        Member member = (Member) o;
        return Objects.equals(id, member.id) &&
               Objects.equals(username, member.username);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, username);
    }
}
