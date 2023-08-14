package com.multi.hontrip.mate.dto;

import com.multi.hontrip.mate.exception.EnumException;
import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
public enum Gender {
    MALE(1, "남성"), FEMALE(2, "여성"), ALLGENDER(3, "성별무관");

    private final int genderNum;
    private final String genderStr;

    public int getGenderNum() {
        return genderNum;
    }

    public String getGenderStr() {
        return genderStr;
    }

    public static Gender valueOf(int genderNum) {
        switch (genderNum) {
            case 0:
                return MALE;
            case 1:
                return FEMALE;
            case 2:
                return ALLGENDER;
            default:
                throw new EnumException("Unknown Gender Value" + genderNum);
        }
    }

}
