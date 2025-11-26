package com.jobmate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jobmate.domain.InterviewHistory;
import com.jobmate.mapper.InterviewHistoryMapper;

@Service
public class InterviewHistoryServiceImpl implements InterviewHistoryService {

    @Autowired
    private InterviewHistoryMapper interviewHistoryMapper;

    @Override
    public void save(InterviewHistory history) {
        interviewHistoryMapper.insert(history);
    }

    @Override
    public List<InterviewHistory> getListByMember(Long memberId) {   // ★ String -> Long
        return interviewHistoryMapper.findByMemberId(memberId);
    }

    @Override
    public InterviewHistory getDetail(Long id, Long memberId) {      // ★ String -> Long
        return interviewHistoryMapper.findByIdAndMemberId(id, memberId);
    }
}

