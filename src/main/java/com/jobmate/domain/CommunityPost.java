package com.jobmate.domain;

import lombok.Data;

@Data
public class CommunityPost {

    private Long id;
    private String category;
    private String title;
    private String content;
    private String writer;

    // DB의 writer_profile 컬럼 → 정확히 매핑됨
    private String writerProfile;

    // DB의 created_at 컬럼 → 정확히 매핑됨
    private String createdAt;
}
