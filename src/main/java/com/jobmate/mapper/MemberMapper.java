package com.jobmate.mapper;

import org.apache.ibatis.annotations.Mapper;
import com.jobmate.domain.Member;

@Mapper
public interface MemberMapper {
    void insertMember(Member member);

    // 필요 시 추후 조회/수정/삭제 메서드들:
    // Member selectByUsername(String username);
    // int updateMember(Member member);
    // int deleteMember(Long id);
}
