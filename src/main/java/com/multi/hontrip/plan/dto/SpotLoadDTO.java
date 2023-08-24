package com.multi.hontrip.plan.dto;

import lombok.Data;

@Data
public class SpotLoadDTO {

    private Long planId;    // 일정 id
    private Long userId;    // 사용자 id
    private String contentId;   // 여행지 콘텐츠 아이디
    private String title;   // 여행지명
    private String image;   // 여행지 이미지
    private int DayOrder;   // 일차
}
