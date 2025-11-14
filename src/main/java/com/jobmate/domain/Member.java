package com.jobmate.domain;

public class Member {

    private Long id;                 // 회원 ID
    private String username;         // 아이디
    private String password;         // 비밀번호
    private String email;            // 이메일
    private String phone;            // 전화번호
    private String careerType;       // 경력 여부 (NEW, EXP)
    private String region;           // 지역
    private String certifications;   // 자격증
    private String name;             // 이름

    // 🔥 새로 추가된 필드 (프로필 이미지 저장 경로)
    private String profileImage;

    // Getter / Setter -----------------------

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }
 
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }
 
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCareerType() {
        return careerType;
    }
 
    public void setCareerType(String careerType) {
        this.careerType = careerType;
    }

    public String getRegion() {
        return region;
    }
 
    public void setRegion(String region) {
        this.region = region;
    }

    public String getCertifications() {
        return certifications;
    }
 
    public void setCertifications(String certifications) {
        this.certifications = certifications;
    }

    public String getName() {
        return name;
    }
 
    public void setName(String name) {
        this.name = name;
    }

    // 🔥 프로필 이미지 Getter / Setter
    public String getProfileImage() {
        return profileImage;
    }
 
    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }
}
