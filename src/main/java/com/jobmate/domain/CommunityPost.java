package com.jobmate.domain;

import lombok.Data;

@Data
public class CommunityPost {

    private Long id;
    private String category;
    private String title;
    private String content;
    private String writer;

    // DB BLOB
    private byte[] writerProfileBlob;

    // JSP에서 쓸 Base64 URL
    private String writerProfileBase64;
    
    private byte[] postImageBlob;      // 이미지 BLOB
    private String postImageBase64;    // JSP 출력용(Base64)


    private String createdAt;
}
