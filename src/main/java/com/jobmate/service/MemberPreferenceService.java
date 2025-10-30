package com.jobmate.service;

import com.jobmate.domain.MemberPreference;
import com.jobmate.dto.MemberDto;
import com.jobmate.mapper.MemberPreferenceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberPreferenceService {

    @Autowired
    private MemberPreferenceMapper memberPreferenceMapper;

    public void savePreference(MemberDto dto, Long memberId) {
        MemberPreference pref = new MemberPreference();
        pref.setMemberId(memberId);

        // ✅ DTO → Domain 매핑
        pref.setOccCodesCsv(dto.getJobCodesCsv());
        pref.setRegionCodesCsv(dto.getWorkRegionCodesCsv());
        pref.setEmploymentType(dto.getEmploymentType());
        pref.setCareerLevel(dto.getCareerLevel());
        pref.setKeyword(dto.getKeyword());

        // ✅ MERGE 실행
        memberPreferenceMapper.upsert(pref);
    }
    // ✅ memberId로 선호정보 조회 (JobAggregationService에서 사용)
    public MemberPreference getByMemberId(Long memberId) {
        return memberPreferenceMapper.findByMemberId(memberId);
    }

    // ✅ 선호정보 저장 (회원가입 시 호출)
    public void savePreference(MemberPreference pref) {
        memberPreferenceMapper.upsert(pref);
    }
    
}
