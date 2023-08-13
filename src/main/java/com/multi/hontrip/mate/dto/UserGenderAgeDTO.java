package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class UserGenderAgeDTO {
    private long id;
    private AgeRange ageRange;
    private Gender gender;
}
