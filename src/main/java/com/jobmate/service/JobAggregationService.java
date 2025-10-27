package com.jobmate.service;

import com.jobmate.domain.MemberPreference;
import com.jobmate.dto.JobPosting;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class JobAggregationService {

    @Autowired
    private MemberPreferenceService prefService;

    // Spring이 같은 타입의 Bean(Work24Adapter 등)을 자동 주입
    @Autowired
    private List<JobSourceAdapter> adapters;

    public List<JobPosting> getRecommendations(Long memberId, int page, int size) {
        MemberPreference pref = prefService.getByMemberId(memberId);
        if (pref == null) return Collections.emptyList();

        List<JobPosting> all = new ArrayList<>();
        for (JobSourceAdapter a : adapters) {
            try {
                all.addAll(a.fetch(pref, page, size));
            } catch (Exception ignore) {}
        }

        // 간단 dedup: source + sourcePostingId
        Map<String, JobPosting> uniq = new LinkedHashMap<>();
        for (JobPosting p : all) {
            if (p == null) continue;
            String key = p.getSource() + "::" + p.getSourcePostingId();
            uniq.putIfAbsent(key, p);
        }
        return new ArrayList<>(uniq.values());
    }
}
