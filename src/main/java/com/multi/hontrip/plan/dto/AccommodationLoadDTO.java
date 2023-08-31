package com.multi.hontrip.plan.dto;

import lombok.Data;

@Data
public class AccommodationLoadDTO {
    private Long planId;
    private Long userId;
    private int dayOrder;
    private Long accommodationId; // 숙박시설 식별자
    private String id; // 카카오맵 api 내 숙박시설 id
    private String placeName; // 카카오맵 api 내 숙박시설 이름
    private String categoryName; // 카카오맵 api 내 카테고리 이름
    private String categoryGroupCode; // 카카오맵 api 내 카테고리 그룹 코드
    private String categoryGroupName; // 카카오맵 api 내 카테고리 그룹 이름
    private String phone; // 카카오맵 api 내 숙박시설 번호
    private String addressName; // 카카오맵 api 내 숙박시설 주소
    private String roadAddressName; // 카카오맵 api 내 숙박시설 도로명 주소
    private String x; // 카카오맵 api 내 x좌표
    private String y; // 카카오맵 api 내 y좌표
    private String placeUrl; // 카카오맵 api 내 숙박시설 url
    private String distance; // 카카오맵 api 내 검색 좌표로부터 거리
}
