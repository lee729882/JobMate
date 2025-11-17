package com.jobmate.mapper;

import com.jobmate.domain.Member;
import org.apache.ibatis.annotations.*;

@Mapper
public interface MemberMapper {

    // 이메일로 조회
    @Select("SELECT ID, USERNAME, PASSWORD, EMAIL, NAME, PHONE, CAREER_TYPE, REGION, CERTIFICATIONS, PROFILE_IMAGE_BLOB " +
            "FROM MEMBER WHERE EMAIL = #{email}")
    Member findByEmail(String email);

    // username 중복 체크
    @Select("SELECT CASE WHEN COUNT(1) > 0 THEN 1 ELSE 0 END FROM MEMBER WHERE USERNAME = #{username}")
    boolean existsByUsername(String username);

    // email 중복 체크
    @Select("SELECT CASE WHEN COUNT(1) > 0 THEN 1 ELSE 0 END FROM MEMBER WHERE EMAIL = #{email}")
    boolean existsByEmail(String email);

    // 신규 회원 가입
    @Insert("INSERT INTO MEMBER (ID, USERNAME, PASSWORD, EMAIL, NAME, PHONE, CAREER_TYPE, REGION, CERTIFICATIONS) " +
            "VALUES (MEMBER_SEQ.NEXTVAL, #{username}, #{password}, #{email}, #{name}, #{phone}, #{careerType}, #{region}, #{certifications})")
    void insertMember(Member member);

    // username으로 조회 (로그인용)
    @Select("SELECT ID, USERNAME, PASSWORD, EMAIL, NAME, PHONE, CAREER_TYPE, REGION, CERTIFICATIONS, PROFILE_IMAGE_BLOB " +
            "FROM MEMBER WHERE USERNAME = #{username}")
    Member findByUsername(String username);

    // ID로 조회
    @Select("SELECT ID, USERNAME, PASSWORD, EMAIL, NAME, PHONE, CAREER_TYPE, REGION, CERTIFICATIONS, PROFILE_IMAGE_BLOB " +
            "FROM MEMBER WHERE ID = #{id}")
    Member findById(Long id);

    // 프로필 업데이트
    @Update("UPDATE MEMBER SET " +
            "EMAIL = #{email}, " +
            "PHONE = #{phone}, " +
            "CAREER_TYPE = #{careerType}, " +
            "REGION = #{region}, " +
            "CERTIFICATIONS = #{certifications}, " +
            "NAME = #{name}, " +
            "PROFILE_IMAGE_BLOB = #{profileImageBlob, jdbcType=BLOB} " +
            "WHERE ID = #{id}")
    void updateProfile(Member member);


    // ==============================================
    // ⭐ 비밀번호 찾기 - 임시 비밀번호 저장 기능 추가
    // ==============================================
    @Update("UPDATE MEMBER SET PASSWORD = #{password} WHERE USERNAME = #{username}")
    void updatePassword(@Param("username") String username,
                        @Param("password") String password);

}
