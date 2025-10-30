package com.jobmate.mapper;

import com.jobmate.domain.Member;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Insert;

@Mapper
public interface MemberMapper {

    /** 아이디 중복 여부 확인 */
    @Select("SELECT CASE WHEN COUNT(1) > 0 THEN 1 ELSE 0 END FROM MEMBER WHERE USERNAME = #{username}")
    boolean existsByUsername(String username);

    /** 이메일 중복 여부 확인 */
    @Select("SELECT CASE WHEN COUNT(1) > 0 THEN 1 ELSE 0 END FROM MEMBER WHERE EMAIL = #{email}")
    boolean existsByEmail(String email);

    /** 회원 등록 */
    @Insert("INSERT INTO MEMBER (" +
            "USERNAME, PASSWORD, EMAIL, PHONE, CAREER_TYPE, REGION, CERTIFICATIONS" +
            ") VALUES (" +
            "#{username}, #{password}, #{email}, #{phone}, #{careerType}, #{region}, #{certifications}" +
            ")")
    void insert(Member member);

    /** 사용자명으로 조회 */
    @Select("SELECT ID, USERNAME, PASSWORD, EMAIL, PHONE, CAREER_TYPE, REGION, CERTIFICATIONS " +
            "FROM MEMBER WHERE USERNAME = #{username}")
    Member findByUsername(String username);
}
