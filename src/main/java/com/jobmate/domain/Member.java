package com.jobmate.domain;

public class Member {
    private Long id;
    private String username;
    private String password;
    private String email;
    private String phone;
    private String careerType;
    private String region;
    private String certifications;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

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
