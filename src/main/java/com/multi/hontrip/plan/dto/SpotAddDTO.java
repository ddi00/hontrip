package com.multi.hontrip.plan.dto;

import lombok.Data;

@Data
public class SpotAddDTO {

    private Long planId;    // 일정 아이디
    private String contentId;   // 여행지 콘텐츠 아이디
    private String title;   // 여행지 타이틀
    private String image;   // 여행지 이미지

}
