package com.jobmate.service;

import java.util.List;
import com.jobmate.domain.InterviewHistory;

public interface InterviewHistoryService {

    void save(InterviewHistory history);

    List<InterviewHistory> getListByMember(Long memberId);

    InterviewHistory getDetail(Long id, Long memberId);
}
