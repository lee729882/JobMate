package com.jobmate.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.jobmate.mapper.RecentViewedMapper;

@Service
public class RecentViewedService {

    @Autowired
    private RecentViewedMapper recentViewedMapper;

    public void addRecentViewed(Long memberId, String source, String seqno,
                                String title, String company, String deadline) {
        // 중복 제거 후 삽입
        recentViewedMapper.deleteDuplicate(memberId, seqno);
        recentViewedMapper.addRecentViewed(memberId, source, seqno, title, company, deadline);
    }

    public List<Map<String, Object>> getRecentViewedList(Long memberId) {
        return recentViewedMapper.getRecentViewedList(memberId);
    }
}
