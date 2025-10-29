package com.jobmate.mapper;

import com.jobmate.domain.MemberPreference;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

import org.apache.ibatis.annotations.Insert;

@Mapper
public interface MemberPreferenceMapper {

    MemberPreference findByMemberId(@Param("memberId") Long memberId);

    int upsert(MemberPreference pref);

    // 필요 시 XML에 정의된 다른 메서드들
    List<MemberPreference> findAll();

    int deleteByMemberId(@Param("memberId") Long memberId);
}

