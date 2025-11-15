package com.jobmate.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jobmate.domain.CommunityPost;
import com.jobmate.mapper.CommunityMapper;

@Service
public class CommunityService {

    @Autowired
    private CommunityMapper communityMapper;

    public List<CommunityPost> getPostsByCategory(String category) {
        return communityMapper.findByCategory(category);
    }

    public void savePost(String category, String title, String content,
                         String writer, String writerProfile) {

        CommunityPost post = new CommunityPost();
        post.setCategory(category);
        post.setTitle(title);
        post.setContent(content);
        post.setWriter(writer);

        // ❗ 오타 수정된 부분
        post.setWriterProfile(writerProfile);

        communityMapper.insertPost(post);
    }

    public CommunityPost getPost(Long id) {
        return communityMapper.findById(id);
    }

    public void deletePost(Long id) {
        communityMapper.deletePost(id);
    }
}

