package com.jobmate.domain;

public class CommunityPost {

    private Long id;
    private String category;
    private String title;
    private String content;
    private String writer;

    private byte[] writerProfileBlob;
    private String writerProfileBase64;

    private byte[] postImageBlob;
    private String postImageBase64;

    private Integer likeCount;
    private Boolean likedByMe;

    private String createdAt;

    // ==== 순수 getter/setter만 존재해야 함 ====

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getWriter() { return writer; }
    public void setWriter(String writer) { this.writer = writer; }

    public byte[] getWriterProfileBlob() { return writerProfileBlob; }
    public void setWriterProfileBlob(byte[] writerProfileBlob) { this.writerProfileBlob = writerProfileBlob; }

    public String getWriterProfileBase64() { return writerProfileBase64; }
    public void setWriterProfileBase64(String writerProfileBase64) { this.writerProfileBase64 = writerProfileBase64; }

    public byte[] getPostImageBlob() { return postImageBlob; }
    public void setPostImageBlob(byte[] postImageBlob) { this.postImageBlob = postImageBlob; }

    public String getPostImageBase64() { return postImageBase64; }
    public void setPostImageBase64(String postImageBase64) { this.postImageBase64 = postImageBase64; }

    public Integer getLikeCount() { return likeCount; }
    public void setLikeCount(Integer likeCount) { this.likeCount = likeCount; }

    public Boolean getLikedByMe() { return likedByMe; }
    public void setLikedByMe(Boolean likedByMe) { this.likedByMe = likedByMe; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}
