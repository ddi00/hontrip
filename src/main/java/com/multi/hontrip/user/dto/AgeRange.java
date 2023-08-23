package com.multi.hontrip.user.dto;

import java.util.Arrays;

public enum AgeRange {  //나이정보 테이블 - Oauth마다 다름, DB에 넣을 때 필요
    AGE_UNKNOWN("나이정보 없음", 1),
    AGE_0_9("0-9", 2),
    AGE_10_19("10-19", 3),
    AGE_20_29("20-29", 4),
    AGE_30_39("30-39", 5),
    AGE_40_49("40-49", 6),
    AGE_50_59("50-59", 7),
    AGE_60_PLUS("60세 이상", 8);

    private final String description;
    private final int id;

    AgeRange(String description, int id) {
        this.description = description;
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public int getId() {
        return id;
    }
    public static AgeRange fromId(int id) { //id찾기
        return Arrays.stream(values())
                .filter(range -> range.getId() == id)
                .findFirst()
                .orElse(AGE_UNKNOWN); // 해당 id에 맞는 AgeRange 멤버를 찾지 못한 경우 "나이정보 없음"을 반환

    }
    public static String getDescriptionFromId(int id) { //id로 연령대 string 찾기
        AgeRange ageRange = AgeRange.fromId(id);
        return ageRange.getDescription();
    }
}
