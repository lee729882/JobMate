package com.jobmate.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.jobmate.domain.Member;

@Mapper
public interface MemberMapper {
    int existsByUsername(@Param("username") String username);
    int existsByEmail(@Param("email") String email);

    void insertMember(Member member);
    Member findByUsername(@Param("username") String username); // 추가

    // 필요 시 추후 조회/수정/삭제 메서드들:
    // Member selectByUsername(String username);
    // int updateMember(Member member);
    // int deleteMember(Long id);
}
