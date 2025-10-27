package com.jobmate.mapper;

import com.jobmate.domain.MemberPreference;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberPreferenceMapper {
    MemberPreference findByMemberId(Long memberId);
    int upsert(MemberPreference pref);
    int deleteByMemberId(Long memberId);
    java.util.List<MemberPreference> findAll();
}

