package com.multi.hontrip.plan.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class EmergencyFacilityDTO { // 응급시설(병원|약국)
    private Long EmergencyFacilityId; // 응급시설 식별자
    private String id; // 카카오맵 api 내 응급시설 id
    private String placeName; // 카카오맵 api 내 응급시설 이름
    private String categoryName; // 카카오맵 api 내 카테고리 이름
    private String categoryGroupCode; // 카카오맵 api 내 카테고리 그룹코드
    private String categoryGroupName; // 카카오맵 api 내 카테고리 그룹 이름
    private String phone; // 카카오맵 api 내 응급시설 번호
    private String addressName; // 카카오맵 api 내 응급시설 주소
    private String roadAddressName; // 카카오맵 api 내 응급시설 도로명 주소
    private String x; // 카카오맵 api 내 x좌표
    private String y; // 카카오맵 api 내 y좌표
    private String placeUrl; // 카카오맵 api 내 응급시설 상세페이지 url
    private String distance; // 검색 좌표로부터 거리
}