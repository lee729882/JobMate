package com.jobmate.service;

import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jobmate.domain.CommunityPost;
import com.jobmate.mapper.CommunityMapper;

@Service
public class CommunityService {

    @Autowired
    private CommunityMapper communityMapper;

    /** 🔥 카테고리별 게시글 조회 + Base64 변환 */
    public List<CommunityPost> getPostsByCategory(String category) {

        List<CommunityPost> posts = communityMapper.findByCategory(category);

        for (CommunityPost post : posts) {

            /** 1) 프로필 이미지 Base64 변환 */
            if (post.getWriterProfileBlob() != null) {
                String base64 = Base64.getEncoder().encodeToString(post.getWriterProfileBlob());
                post.setWriterProfileBase64("data:image/png;base64," + base64);
            }

            /** 2) 게시물 이미지 Base64 변환 */
            if (post.getPostImageBlob() != null) {
                String base64 = Base64.getEncoder().encodeToString(post.getPostImageBlob());
                post.setPostImageBase64("data:image/png;base64," + base64);
            }
        }

        return posts;
    }


    /** 🔥 게시물 저장 (프로필 + 게시물 이미지 BLOB) */
    public void savePost(String category, String title, String content,
                         String writer, byte[] writerProfileBlob, byte[] postImageBlob) {

        CommunityPost post = new CommunityPost();
        post.setCategory(category);
        post.setTitle(title);
        post.setContent(content);
        post.setWriter(writer);

        // 프로필(작성자) 이미지 BLOB
        post.setWriterProfileBlob(writerProfileBlob);

        // 게시물 이미지 BLOB
        post.setPostImageBlob(postImageBlob);

        communityMapper.insertPost(post);
    }


    /** 🔥 단건 조회 (+ Base64 변환) */
    public CommunityPost getPost(Long id) {

        CommunityPost post = communityMapper.findById(id);

        if (post != null) {

            if (post.getWriterProfileBlob() != null) {
                String base64 = Base64.getEncoder().encodeToString(post.getWriterProfileBlob());
                post.setWriterProfileBase64("data:image/png;base64," + base64);
            }

            if (post.getPostImageBlob() != null) {
                String base64 = Base64.getEncoder().encodeToString(post.getPostImageBlob());
                post.setPostImageBase64("data:image/png;base64," + base64);
            }
        }

        return post;
    }


    /** 삭제 */
    public void deletePost(Long id) {
        communityMapper.deletePost(id);
    }
}
