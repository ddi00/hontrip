package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class MateDTO {

    private long mateBoardId;
    private long user_id;
    private long region_id;
    private long age_range_id;
    private String title;
    private String content;
    private String thumbnail;
    private String startDate;
    private String finishDate;
    private boolean isFinish;
    private int recruitNumber;

}
