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

    /** ✅ 회원가입 */
    public void register(MemberDto dto) {
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

        // ✅ insertMember만 호출
        memberMapper.insertMember(m);
    }

    /** ✅ 아이디로 회원 조회 */
    public Member findByUsername(String username) {
        return memberMapper.findByUsername(username);
    }

    /** ✅ 로그인 인증 (아이디 + 비밀번호 확인) */
    public Member authenticate(String username, String password) {
        Member found = memberMapper.findByUsername(username);
        if (found == null) return null;

        if (found.getPassword().equals(password)) {
            return found;
        }
        return null;
    }
}
