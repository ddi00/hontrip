package com.multi.hontrip.mate.dto;

import com.multi.hontrip.mate.exception.EnumException;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public enum AgeRange {

    TEENAGER(1, "10대"), TWENTIES(2, "20대"), THIRTIES(3, "30대"),
    FORTIES(4, "40대"), FIFTIES(5, "50대"), SIXTIES(6, "60대"), SEVENTIES(7, "70대"),
    ALLAGE(0, "전연령");

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
