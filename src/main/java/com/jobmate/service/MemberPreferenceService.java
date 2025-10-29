package com.jobmate.service;

import com.jobmate.domain.MemberPreference;
import com.jobmate.mapper.MemberPreferenceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberPreferenceService {

    @Autowired
    private MemberPreferenceMapper mapper;

    /** ✅ 기존 findByMemberId (있다면 그대로 둠) */
    public MemberPreference findByMemberId(Long memberId) {
        return mapper.findByMemberId(memberId);
    }

    /** ✅ JobsController 등에서 getByMemberId() 로 호출해도 동작하도록 별칭 추가 */
    public MemberPreference getByMemberId(Long memberId) {
        return findByMemberId(memberId);
    }

    /** ✅ 선호정보 저장/갱신 */
    public void save(MemberPreference pref) {
        mapper.upsert(pref);
    }
}
