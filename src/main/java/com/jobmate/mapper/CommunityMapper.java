package com.jobmate.mapper;

import com.jobmate.domain.CommunityPost;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CommunityMapper {
    List<CommunityPost> findByCategory(String category);
    CommunityPost findById(Long id);
    void insertPost(CommunityPost post);
    void deletePost(Long id);
}
