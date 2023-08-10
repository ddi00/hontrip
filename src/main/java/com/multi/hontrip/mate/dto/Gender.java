package com.multi.hontrip.mate.dto;

import com.multi.hontrip.mate.exception.EnumException;
import lombok.Getter;

@Getter
public enum Gender {
    MALE(0), FEMALE(1), ALLGENDER(2);

    private final int genderNum;

    Gender(int genderNum) {
        this.genderNum = genderNum;
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

    public int getValue() {
        return this.genderNum;
    }


}
