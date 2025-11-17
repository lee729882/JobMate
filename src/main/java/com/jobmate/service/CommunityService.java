package com.jobmate.service;

import java.util.Base64;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jobmate.domain.CommunityPost;
import com.jobmate.mapper.CommunityMapper;

@Service
public class CommunityService {

    @Autowired
    private CommunityMapper communityMapper;

    /**
     * 🔥 카테고리별 게시글 조회 + Base64 변환 + 좋아요 여부 포함
     */
    public List<CommunityPost> getPostsByCategory(String category, Long userId) {

        List<CommunityPost> posts = communityMapper.findByCategory(category);

        for (CommunityPost post : posts) {
            applyBase64(post);

            // 로그인 유저 좋아요 여부
            int liked = communityMapper.isLiked(post.getId(), userId);
            post.setLikedByMe(liked == 1);
        }

        return posts;
    }

    /**
     * 🔥 게시물 저장
     */
    public void savePost(String category, String title, String content,
                         String writer, byte[] writerProfileBlob, byte[] postImageBlob) {

        CommunityPost post = new CommunityPost();
        post.setCategory(category);
        post.setTitle(title);
        post.setContent(content);
        post.setWriter(writer);
        post.setWriterProfileBlob(writerProfileBlob);
        post.setPostImageBlob(postImageBlob);

        communityMapper.insertPost(post);
    }

    /**
     * 🔥 단일 게시물 조회 (+ 좋아요 여부 포함)
     */
    public CommunityPost getPost(Long id, Long userId) {

        CommunityPost post = communityMapper.findById(id);
        if (post != null) {

            applyBase64(post);

            int liked = communityMapper.isLiked(post.getId(), userId);
            post.setLikedByMe(liked == 1);
        }
        return post;
    }

    /**
     * ❤️ 좋아요 토글
     */
    @Transactional
    public boolean toggleLike(Long postId, Long userId) {

        int liked = communityMapper.isLiked(postId, userId);

        if (liked == 0) {
            communityMapper.insertLike(postId, userId);
            communityMapper.increaseLike(postId);
            return true;

        } else {
            communityMapper.deleteLike(postId, userId);
            communityMapper.decreaseLike(postId);
            return false;
        }
    }

    /**
     * 🔥 좋아요 최신 개수 조회
     */
    @Transactional(readOnly = true)
    public int getLikeCount(Long postId) {
        return communityMapper.getLikeCount(postId);
    }

    /**
     * 🔥 게시글 삭제 (좋아요 먼저 삭제 후 게시물 삭제)
     */
    @Transactional
    public void deletePost(Long id) {

        // 1) 자식 테이블(POST_LIKE) 삭제
        communityMapper.deleteLikesByPost(id);

        // 2) 부모 테이블(COMMUNITY_POST) 삭제
        communityMapper.deletePost(id);
    }

    /**
     * 🔥 게시글 수정
     */
    public void updatePost(Long id, String title, String content, byte[] postImageBlob) {
        communityMapper.updatePost(id, title, content, postImageBlob);
    }

    /**
     * ❤️ 내가 좋아요한 게시물 리스트 가져오기
     */
    public List<CommunityPost> getLikedPosts(Long userId) {

        List<CommunityPost> posts = communityMapper.findLikedPostsByUser(userId);

        for (CommunityPost post : posts) {
            applyBase64(post);

            // 내가 좋아요한 목록이므로 true 고정
            post.setLikedByMe(true);
        }

        return posts;
    }

    /**
     * 공통 Base64 변환
     */
    private void applyBase64(CommunityPost post) {

        // 작성자 프로필
        if (post.getWriterProfileBlob() != null) {
            String base64 = Base64.getEncoder().encodeToString(post.getWriterProfileBlob());
            post.setWriterProfileBase64("data:image/png;base64," + base64);
        }

        // 게시물 이미지
        if (post.getPostImageBlob() != null) {
            String base64 = Base64.getEncoder().encodeToString(post.getPostImageBlob());
            post.setPostImageBase64("data:image/png;base64," + base64);
        }
    }
}
