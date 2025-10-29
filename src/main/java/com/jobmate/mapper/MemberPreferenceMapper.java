package com.jobmate.mapper;

import com.jobmate.domain.MemberPreference;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;

@Mapper
public interface MemberPreferenceMapper {

    // XML에 정의된 쿼리와 1:1 연결됨
    MemberPreference findByMemberId(@Param("memberId") Long memberId);

    int upsert(MemberPreference pref);

    List<MemberPreference> findAll();

    int deleteByMemberId(@Param("memberId") Long memberId);
}
