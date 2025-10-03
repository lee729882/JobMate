package com.jobmate.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.jobmate.domain.Member;
import org.springframework.util.StringUtils;

import com.jobmate.domain.Member;
import com.jobmate.dto.MemberDto;
import com.jobmate.mapper.MemberMapper;

import java.util.StringJoiner;

@Service
public class MemberService {

    @Autowired
    private MemberMapper memberMapper;

    public void register(MemberDto dto) {
        Member member = new Member();
        member.setUsername(dto.getUsername());
        member.setPassword(dto.getPassword()); // 실제 운영 시 반드시 BCrypt 등으로 해시 권장
        member.setEmail(dto.getEmail());
        member.setName(dto.getName());
        member.setCareerType(dto.getCareerType());
        member.setEduCode(dto.getEduCode());
        member.setMinSalary(dto.getMinSalary());

        // String[] -> CSV
        member.setJobCodes(toCsv(dto.getJobCodes()));
        member.setWorkRegionCodes(toCsv(dto.getWorkRegionCodes()));

        memberMapper.insertMember(member);
    }

    private String toCsv(String[] arr) {
        if (arr == null || arr.length == 0) return null;
        StringJoiner sj = new StringJoiner(",");
        for (String s : arr) {
            if (s != null && !s.trim().isEmpty()) {
                sj.add(s.trim());
            }
        }
        String result = sj.toString();
        return result.isEmpty() ? null : result;
    }
    public Member authenticate(String username, String rawPassword) {
        if (!StringUtils.hasText(username) || !StringUtils.hasText(rawPassword)) return null;
        Member found = memberMapper.findByUsername(username);
        if (found == null || found.getPassword() == null) return null;

        String stored = found.getPassword();

        // (선택) 나중에 비번을 BCrypt로 저장하면 아래 주석을 해제
        /*
        if (stored.startsWith("$2a$") || stored.startsWith("$2b$") || stored.startsWith("$2y$")) {
            return BCrypt.checkpw(rawPassword, stored) ? found : null;
        }
        */

        // 현재는 평문 비교 (초기 데이터 호환)
        return stored.equals(rawPassword) ? found : null;
    }
}
