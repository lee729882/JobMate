package com.jobmate.dto;

import org.hibernate.validator.constraints.NotBlank;

public class MemberDto {
    @NotBlank(message = "아이디는 필수입니다.")
    private String username;

    @NotBlank(message = "비밀번호는 필수입니다.")
    private String password;

    @NotBlank(message = "이메일은 필수입니다.")
    private String email;

    private String phone;
    private String careerType;
    private String region;
    private String certifications;

    // Getters & Setters
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getCareerType() { return careerType; }
    public void setCareerType(String careerType) { this.careerType = careerType; }

    public String getRegion() { return region; }
    public void setRegion(String region) { this.region = region; }

    public String getCertifications() { return certifications; }
    public void setCertifications(String certifications) { this.certifications = certifications; }
}
