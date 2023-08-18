package com.multi.hontrip.mate.dto;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
public enum Gender {
    NONE(1, "정보없음"), MALE(2, "남성"), FEMALE(3, "여성"), ALLGENDER(4, "성별무관");

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
            case 1:
                return NONE;
            case 2:
                return MALE;
            case 3:
                return FEMALE;
            case 4:
                return ALLGENDER;
        }
        return null;
    }

}
