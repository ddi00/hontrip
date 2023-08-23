package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class MateBoardListDTO {

    private long mateBoardId;
    private String nickname;
    private String title;
    private String content;
    private String thumbnail;
    private String ageRange;
    private String startDate;
    private String endDate;
}
