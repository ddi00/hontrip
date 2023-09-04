package com.multi.hontrip.plan.dto;

import lombok.Data;

@Data
public class SpotInfoDTO {
    // 홈에 즐겨찾기 수 상위 10개 여행지 반환 위한 dto
    private String title;
    private String image;
    private String spotContentId;
    private String area;
}
