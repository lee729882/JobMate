package com.jobmate.domain;

import lombok.Data;

@Data
public class Member {

    private Long id;                 
    private String username;         
    private String password;         
    private String email;            
    private String phone;            
    private String careerType;       
    private String region;           
    private String certifications;   
    private String name;             

    // 🔥 실제 파일은 /resources/profile 에 저장하고
    // DB에는 "/resources/profile/파일명.jpg" 만 저장
    private String profileImage;  

    // 🔥 BLOB 저장용 필드 추가
    private byte[] profileImageBlob;
}
