package com.multi.hontrip.plan.dto;

import lombok.Data;

@Data
public class SpotDTO {

    private int id;                 // 여행지 id
    private String contentId;       // 여행지 id - api
    private String contentTypeId;   // 여행지 타입 id (관광지, 문화시설, 축제공연행사, 여행코스, 레포츠, 숙박, 쇼핑, 음식점)
    private String title;           // 여행지명
    private String tel;             // 전화번호
    private String image;      // 대표 이미지 주소
    private String homepage;        // 홈페이지 주소
    private String address;         // 주소
    private String mapX;            // 경도
    private String mapY;           // 위도
    private String areaCode;        // 지역코드
    private String sigunguCode;     // 시군구코드
    private String overview;        // 개요
    private String infoCenter;      // 문의 및 안내
    private String openDate;        // 개장일
    private String restDate;        // 휴일
    private String expguide;        // 체험 안내
    private String usetime;         // 이용 시간
    private String parking;         // 주차 시설

}
