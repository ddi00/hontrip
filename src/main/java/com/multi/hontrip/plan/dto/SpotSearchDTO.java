package com.multi.hontrip.plan.dto;

import lombok.Data;

@Data
public class SpotSearchDTO {

//    private String contentId;       // 여행지 콘텐츠 id
//    private String contentTypeId;   // 여행지 타입 id
    private String keyword;           // 검색어 (키워드 or 지역명)
//    private String sigunguName;     // 시군구명
    private String category;  // 검색 범주 (키워드 or 지역)
}
