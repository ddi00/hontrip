package com.multi.hontrip.plan.dto;

import lombok.Data;

@Data
public class SpotLoadDTO {

    private Long planId;
    private Long userId;
    private String contentId;
    private String title;
    private String image;
    private int DayOrder;
}
