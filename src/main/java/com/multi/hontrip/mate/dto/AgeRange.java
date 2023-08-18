package com.multi.hontrip.mate.dto;

import com.multi.hontrip.mate.exception.EnumException;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public enum AgeRange {

    AGE_UNKNOWN(1, "나이정보 없음"),
    TEENAGER(3, "10대"),
    TWENTIES(4, "20대"),
    THIRTIES(5, "30대"),
    FORTIES(6, "40대"),
    FIFTIES(7, "50대"),
    SIXTIES(8, "60대"),
    ALLAGE(9, "전연령");

    private final int ageRangeNum;
    private final String ageRangeStr;

    public int getAgeRangeNum() {
        return ageRangeNum;
    }

    public String getAgeRangeStr() {
        return ageRangeStr;
    }


    public static String valueOf(int num) {
        String str = "";
        for (AgeRange ageRange : AgeRange.values()) {
            if (ageRange.ageRangeNum == num) {
                str = ageRange.ageRangeStr;
            }
        }
        if (str.equals("")) {
            throw new EnumException("해당하는 ENUM이 존재하지 않습니다.");
        }
        return str;
    }
}
