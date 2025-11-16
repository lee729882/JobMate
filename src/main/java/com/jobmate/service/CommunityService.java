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

    /** 카테고리별 게시글 조회 + Base64 변환 */
    public List<CommunityPost> getPostsByCategory(String category) {

        List<CommunityPost> posts = communityMapper.findByCategory(category);

        // 🔥 조회된 BLOB 데이터를 Base64로 변환
        for (CommunityPost post : posts) {
            if (post.getWriterProfileBlob() != null) {
                String base64 = Base64.getEncoder().encodeToString(post.getWriterProfileBlob());
                post.setWriterProfileBase64("data:image/png;base64," + base64);
            }
        }

        return posts;
    }

    public void savePost(String category, String title, String content,
            String writer, byte[] writerProfileBlob) {

		CommunityPost post = new CommunityPost();
		post.setCategory(category);
		post.setTitle(title);
		post.setContent(content);
		post.setWriter(writer);
		post.setWriterProfileBlob(writerProfileBlob);   //  BLOB 저장
		
		communityMapper.insertPost(post);
		}


    /** 단건 조회 */
    public CommunityPost getPost(Long id) {

        CommunityPost post = communityMapper.findById(id);

        // 🔥 Base64 변환
        if (post != null && post.getWriterProfileBlob() != null) {
            String base64 = Base64.getEncoder().encodeToString(post.getWriterProfileBlob());
            post.setWriterProfileBase64("data:image/png;base64," + base64);
        }

        return post;
    }

    /** 삭제 */
    public void deletePost(Long id) {
        communityMapper.deletePost(id);
    }
}
