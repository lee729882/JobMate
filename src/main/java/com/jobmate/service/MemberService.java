package com.jobmate.service;

import com.jobmate.domain.Member;
import com.jobmate.dto.MemberDto;
import com.jobmate.exception.DuplicateEmailException;
import com.jobmate.exception.DuplicateUsernameException;
import com.jobmate.mapper.MemberMapper;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class MemberService {

    @Autowired
    private MemberMapper memberMapper;

    @Autowired
    private MailService mailService;

    // 🔥 BCrypt 비밀번호 암호화기
    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();


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

        // 🔥 비밀번호는 반드시 암호화해서 저장
        m.setPassword(passwordEncoder.encode(dto.getPassword()));

        m.setEmail(dto.getEmail());
        m.setPhone(dto.getPhone());
        m.setName(dto.getName());
        m.setCareerType(dto.getCareerType());
        m.setRegion(dto.getRegion());
        m.setCertifications(dto.getCertifications());
        m.setProfileImageBlob(null); // 프로필 이미지 없음

        memberMapper.insertMember(m);
    }


    /**
     * 🔹 로그인 (아이디 + 비밀번호)
     */
    public Member authenticate(String username, String rawPassword) {
        Member found = memberMapper.findByUsername(username);
        if (found == null) return null;

        // 🔥 BCrypt로 비교
        if (passwordEncoder.matches(rawPassword, found.getPassword())) {
            return found;
        }
        return null;
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

        m.setPassword(null);
        return m;
    }


    /**
     * 🔥 프로필 업데이트
     */
    public void updateProfile(Member member) {

        Member exist = memberMapper.findById(member.getId());
        if (exist == null) {
            throw new IllegalArgumentException("존재하지 않는 회원입니다.");
        }

        // 이메일 중복 검사 (자기 자신 제외)
        Member emailOwner = memberMapper.findByEmail(member.getEmail());
        if (emailOwner != null && !emailOwner.getId().equals(member.getId())) {
            throw new DuplicateEmailException("이미 사용 중인 이메일입니다.");
        }

        memberMapper.updateProfile(member);
    }


    /**
     * 🔥 비밀번호 찾기 - 임시 비밀번호 발급
     */
    public boolean sendTempPassword(String username, String email) {

        Member member = memberMapper.findByUsername(username);

        if (member == null || !member.getEmail().equals(email)) {
            return false;
        }

        // 임시 비밀번호 생성
        String tempPw = UUID.randomUUID().toString().substring(0, 10);

        // DB 저장용 암호화
        String encPw = passwordEncoder.encode(tempPw);

        // DB 업데이트
        memberMapper.updatePassword(username, encPw);

        // 이메일 발송
        String title = "[JobMate] 임시 비밀번호 안내";
        String body =
                "안녕하세요, JobMate입니다.\n\n" +
                "요청하신 임시 비밀번호는 다음과 같습니다.\n\n" +
                "임시 비밀번호: " + tempPw + "\n\n" +
                "※ 반드시 로그인 후 비밀번호를 변경해주세요.";

        mailService.sendMail(email, title, body);

        return true;
    }
}
