package com.jobmate.mapper;

import com.jobmate.domain.Member;
import org.apache.ibatis.annotations.*;

@Mapper
public interface MemberMapper {

    @Select("SELECT ID, USERNAME, PASSWORD, EMAIL, NAME, PHONE, CAREER_TYPE, REGION, CERTIFICATIONS, PROFILE_IMAGE " +
            "FROM MEMBER WHERE EMAIL = #{email}")
    Member findByEmail(String email);

    @Select("SELECT CASE WHEN COUNT(1) > 0 THEN 1 ELSE 0 END FROM MEMBER WHERE USERNAME = #{username}")
    boolean existsByUsername(String username);

    @Select("SELECT CASE WHEN COUNT(1) > 0 THEN 1 ELSE 0 END FROM MEMBER WHERE EMAIL = #{email}")
    boolean existsByEmail(String email);

    @Insert("INSERT INTO MEMBER (ID, USERNAME, PASSWORD, EMAIL, NAME, PHONE, CAREER_TYPE, REGION, CERTIFICATIONS) " +
            "VALUES (MEMBER_SEQ.NEXTVAL, #{username}, #{password}, #{email}, #{name}, #{phone}, #{careerType}, #{region}, #{certifications})")
    void insertMember(Member member);

    @Select("SELECT ID, USERNAME, PASSWORD, EMAIL, NAME, PHONE, CAREER_TYPE, REGION, CERTIFICATIONS, PROFILE_IMAGE " +
            "FROM MEMBER WHERE USERNAME = #{username}")
    Member findByUsername(String username);

    @Select("SELECT ID, USERNAME, PASSWORD, EMAIL, NAME, PHONE, CAREER_TYPE, REGION, CERTIFICATIONS, PROFILE_IMAGE " +
            "FROM MEMBER WHERE ID = #{id}")
    Member findById(Long id);

    @Update("UPDATE MEMBER SET " +
            "EMAIL = #{email}, " +
            "PHONE = #{phone}, " +
            "CAREER_TYPE = #{careerType}, " +
            "REGION = #{region}, " +
            "CERTIFICATIONS = #{certifications}, " +
            "NAME = #{name}, " +
            "PROFILE_IMAGE = #{profileImage} " +    
            "WHERE ID = #{id}")
    void updateProfile(Member member);
}
