package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class UserGenderAgeDTO {
    private long id;            //유저 아이디
    private AgeRange ageRange;  //유저 연령대
    private Gender gender;      //유저 성별

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public AgeRange getAgeRange() {
        return ageRange;
    }

    public void setAgeRange(AgeRange ageRange) {
        this.ageRange = ageRange;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }
}
