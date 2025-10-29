package com.jobmate.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberPreference {

    private Long id;
    private Long memberId;

    // ✅ Mapper XML과 필드명 일치
    private String occCodesCsv;
    private String regionCodesCsv;

    private String employmentType;
    private String careerLevel;
    private String keyword;

    // ✅ CSV → 배열 변환 (선택적으로 사용)
    public String[] getOccCodesArray() {
        return (occCodesCsv != null && !occCodesCsv.isEmpty())
                ? occCodesCsv.split(",")
                : new String[0];
    }

    public String[] getRegionCodesArray() {
        return (regionCodesCsv != null && !regionCodesCsv.isEmpty())
                ? regionCodesCsv.split(",")
                : new String[0];
    }

    @Override
    public String toString() {
        return "MemberPreference{" +
                "memberId=" + memberId +
                ", occCodesCsv='" + occCodesCsv + '\'' +
                ", regionCodesCsv='" + regionCodesCsv + '\'' +
                ", employmentType='" + employmentType + '\'' +
                ", careerLevel='" + careerLevel + '\'' +
                ", keyword='" + keyword + '\'' +
                '}';
    }
}
