package com.jobmate.dto;

import java.util.Arrays;
import com.jobmate.mapper.MemberMapper;

import org.springframework.beans.factory.annotation.Autowired;

public class MemberDto {
    private String username;
    private String password;
    private String email;
    private String name;

    private String careerType; // NEW/EXP/ANY
    private String eduCode;    // ANY/HS/AD/BA/MA/PHD
    private Integer minSalary;

    // 다중 선택 값 (hidden inputs 로 넘어옴)
    private String[] jobCodes;         // 예: ["JOB101","JOB502"]
    private String[] workRegionCodes;  // 예: ["11010","31020"]

    public MemberDto() {}

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

    public String[] getJobCodes() { return jobCodes; }
    public void setJobCodes(String[] jobCodes) { this.jobCodes = jobCodes; }

    public String[] getWorkRegionCodes() { return workRegionCodes; }
    public void setWorkRegionCodes(String[] workRegionCodes) { this.workRegionCodes = workRegionCodes; }

    
 // MemberDto.java (아래 2개 메서드 추가)
    public String getJobCodesCsv() {
        return (jobCodes == null || jobCodes.length == 0) ? null : String.join(",", jobCodes);
    }
    public String getWorkRegionCodesCsv() {
        return (workRegionCodes == null || workRegionCodes.length == 0) ? null : String.join(",", workRegionCodes);
    }

    @Override
    public String toString() {
        return "MemberDto{" +
                "username='" + username + '\'' +
                ", email='" + email + '\'' +
                ", name='" + name + '\'' +
                ", careerType='" + careerType + '\'' +
                ", eduCode='" + eduCode + '\'' +
                ", minSalary=" + minSalary +
                ", jobCodes=" + Arrays.toString(jobCodes) +
                ", workRegionCodes=" + Arrays.toString(workRegionCodes) +
                '}';
    }
}
