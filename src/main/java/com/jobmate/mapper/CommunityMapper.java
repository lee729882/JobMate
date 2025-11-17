package com.jobmate.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.jobmate.domain.CommunityPost;

@Mapper
public interface CommunityMapper {

    // 카테고리별 조회
    List<CommunityPost> findByCategory(String category);

    // 단일 조회
    CommunityPost findById(Long id);

    // 글 작성
    void insertPost(CommunityPost post);

    // 글 삭제
    void deletePost(Long id);

    // 좋아요 여부 확인
    int isLiked(@Param("postId") Long postId, @Param("userId") Long userId);

    // 좋아요 추가
    void insertLike(@Param("postId") Long postId, @Param("userId") Long userId);

    // 좋아요 취소
    void deleteLike(@Param("postId") Long postId, @Param("userId") Long userId);

    // 좋아요 증가
    void increaseLike(Long postId);

    // 좋아요 감소
    void decreaseLike(Long postId);

    // 최신 좋아요 수 조회
    int getLikeCount(Long postId);
    
    void deleteLikesByPost(Long postId);


    // 글 수정
    void updatePost(
        @Param("id") Long id,
        @Param("title") String title,
        @Param("content") String content,
        @Param("postImageBlob") byte[] postImageBlob
    );

    /* ============================================================
       🔥 추가: 내가 좋아요 누른 게시글 목록 조회
       ============================================================ */
    
    List<CommunityPost> findLikedPostsByUser(Long userId);

    
    
}
