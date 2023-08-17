package com.multi.hontrip.plan.dto;

import lombok.Data;

@Data
public class SpotSearchDTO {

    private String contentTypeId;   // 여행지 타입 id
    private String title;           // 여행지명
    private String areaName;        // 지역명
    private String sigunguName;     // 시군구명
}
