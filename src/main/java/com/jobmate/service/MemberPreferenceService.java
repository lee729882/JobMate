package com.jobmate.service;

import com.jobmate.domain.MemberPreference;
import com.jobmate.mapper.MemberPreferenceMapper;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

@Service
public class MemberPreferenceService {

    @Autowired
    private MemberPreferenceMapper mapper;

    public void save(MemberPreference p) {
        mapper.upsert(p);
    }

    public MemberPreference getByMemberId(Long memberId) {
        return mapper.findByMemberId(memberId);
    }
}
