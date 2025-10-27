package com.jobmate.mapper;

import com.jobmate.domain.MemberPreference;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Insert;

@Mapper
public interface MemberPreferenceMapper {

    @Select("SELECT * FROM member_preference WHERE member_id = #{memberId}")
    MemberPreference findByMemberId(Long memberId);

    @Insert(
        "INSERT INTO member_preference(member_id, occ_codes, region_codes, employment_type, career_level, keyword) " +
        "VALUES (#{memberId}, #{occCodesCsv}, #{regionCodesCsv}, #{employmentType}, #{careerLevel}, #{keyword}) " +
        "ON DUPLICATE KEY UPDATE " +
        "occ_codes = #{occCodesCsv}, region_codes = #{regionCodesCsv}, " +
        "employment_type = #{employmentType}, career_level = #{careerLevel}, keyword = #{keyword}"
    )
    int upsert(MemberPreference pref);
}
