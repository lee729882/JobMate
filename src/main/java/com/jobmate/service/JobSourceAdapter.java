package com.jobmate.service;

import com.jobmate.domain.MemberPreference;
import com.jobmate.dto.JobPosting;
import java.util.List;

public interface JobSourceAdapter {
    String sourceName();
    List<JobPosting> fetch(MemberPreference pref, int page, int size);
}
