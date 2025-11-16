package com.jobmate.service;

import com.jobmate.domain.Member;
import com.jobmate.dto.MemberDto;
import com.jobmate.exception.DuplicateEmailException;
import com.jobmate.exception.DuplicateUsernameException;
import com.jobmate.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    @Autowired
    private MemberMapper memberMapper;

    /**
     * 🔹 회원가입
     */
    public void register(MemberDto dto) {

        // 중복 체크
        if (memberMapper.existsByUsername(dto.getUsername())) {
            throw new DuplicateUsernameException("이미 사용 중인 아이디입니다.");
        }
        if (memberMapper.existsByEmail(dto.getEmail())) {
            throw new DuplicateEmailException("이미 등록된 이메일입니다.");
        }

        Member m = new Member();
        m.setUsername(dto.getUsername());
        m.setPassword(dto.getPassword());
        m.setEmail(dto.getEmail());
        m.setPhone(dto.getPhone());
        m.setName(dto.getName());
        m.setCareerType(dto.getCareerType());
        m.setRegion(dto.getRegion());
        m.setCertifications(dto.getCertifications());

        // 가입시 프로필 이미지는 없으므로 null (BLOB)
        m.setProfileImageBlob(null);

        memberMapper.insertMember(m);
    }

    /**
     * 🔹 로그인 (아이디 + 비밀번호)
     */
    public Member authenticate(String username, String password) {
        Member found = memberMapper.findByUsername(username);
        if (found == null) return null;

        return found.getPassword().equals(password) ? found : null;
    }

    /**
     * 🔹 아이디로 조회
     */
    public Member findByUsername(String username) {
        return memberMapper.findByUsername(username);
    }

    /**
     * 🔥 회원 조회 (ID 기준)
     */
    public Member findById(Long id) {
        Member m = memberMapper.findById(id);
        if (m == null) return null;

        m.setPassword(null); // 보안 처리
        return m;
    }

    /**
     * 🔥 프로필 업데이트 (이름/이메일/전화번호/경력/지역/자격증/프로필이미지 BLOB)
     */
    public void updateProfile(Member member) {

        // 1) 존재 여부 확인
        Member exist = memberMapper.findById(member.getId());
        if (exist == null) {
            throw new IllegalArgumentException("존재하지 않는 회원입니다.");
        }

        // 2) 이메일 중복 검사 (자기 자신 제외)
        Member emailOwner = memberMapper.findByEmail(member.getEmail());
        if (emailOwner != null && !emailOwner.getId().equals(member.getId())) {
            throw new DuplicateEmailException("이미 사용 중인 이메일입니다.");
        }

        // 3) 프로필 업데이트
        memberMapper.updateProfile(member);
    }
}
