package com.jobmate.dto;

import org.hibernate.validator.constraints.NotBlank;
import java.util.List;

public class MemberDto {
    @NotBlank(message = "아이디는 필수입니다.")
    private String username;

    @NotBlank(message = "비밀번호는 필수입니다.")
    private String password;

    @NotBlank(message = "이메일은 필수입니다.")
    private String email;

    private String name;

    @NotBlank(message = "경력 여부를 선택하세요.")
    private String careerType;

    @NotBlank(message = "학력을 선택하세요.")
    private String eduCode;

    private Integer minSalary;

    /** ✅ 희망 직종 / 근무지역 (다중선택) */
    private List<String> jobCodes;          // ex) ["JOB501", "JOB502"]
    private List<String> workRegionCodes;   // ex) ["11010", "31020"]

    /** ✅ 추가 입력 항목 */
    private String employmentType;
    private String careerLevel;
    private String keyword;

    /** ✅ JSP hidden input으로 들어오는 CSV 값 (직접 form에서 전달됨) */
    private String jobCodesCsv;
    private String workRegionCodesCsv;

    // ===== Getter / Setter =====
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

    public List<String> getJobCodes() { return jobCodes; }
    public void setJobCodes(List<String> jobCodes) { this.jobCodes = jobCodes; }

    public List<String> getWorkRegionCodes() { return workRegionCodes; }
    public void setWorkRegionCodes(List<String> workRegionCodes) { this.workRegionCodes = workRegionCodes; }

    public String getEmploymentType() { return employmentType; }
    public void setEmploymentType(String employmentType) { this.employmentType = employmentType; }

    public String getCareerLevel() { return careerLevel; }
    public void setCareerLevel(String careerLevel) { this.careerLevel = careerLevel; }

    public String getKeyword() { return keyword; }
    public void setKeyword(String keyword) { this.keyword = keyword; }

    // ✅ CSV 변환 및 폼 입력값 병합 로직
    public String getJobCodesCsv() {
        if (jobCodesCsv != null && !jobCodesCsv.isEmpty()) return jobCodesCsv;
        return (jobCodes == null || jobCodes.isEmpty()) ? null : String.join(",", jobCodes);
    }

    public void setJobCodesCsv(String jobCodesCsv) {
        this.jobCodesCsv = jobCodesCsv;
    }

    public String getWorkRegionCodesCsv() {
        if (workRegionCodesCsv != null && !workRegionCodesCsv.isEmpty()) return workRegionCodesCsv;
        return (workRegionCodes == null || workRegionCodes.isEmpty()) ? null : String.join(",", workRegionCodes);
    }

    public void setWorkRegionCodesCsv(String workRegionCodesCsv) {
        this.workRegionCodesCsv = workRegionCodesCsv;
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
                ", jobCodesCsv='" + jobCodesCsv + '\'' +
                ", workRegionCodesCsv='" + workRegionCodesCsv + '\'' +
                '}';
    }
}
