package com.multi.hontrip.plan.parser;

// 여행지 조회 시 지역 - 지역 id 맵핑 위한 enum class
public enum Area {
    SEOUL("서울", "1"),
    INCHEON("인천", "2"),
    DAEJEON("대전", "3"),
    DAEGU("대구", "4"),
    GWANGJU("광주", "5"),
    BUSAN("부산", "6"),
    ULSAN("울산", "7"),
    SEJONG("세종", "8"),
    SEJONGSI("세종특별자치시", "8"),
    GYEONGGI("경기도", "31"),
    GANGWON("강원도", "32"),
    CHUNGBUK("충청북도", "33"),
    CHUNGNAM("충청남도", "34"),
    GYEONGBUK("경상북도", "35"),
    GYEONGNAM("경상남도", "36"),
    JEONBUK("전라북도", "37"),
    JEONNAM("전라남도", "38"),
    JEJU("제주도", "39");

    private final String areaName;
    private final String areaCode;

    Area(String areaName, String areaCode) {
        this.areaName = areaName;
        this.areaCode = areaCode;
    }

    public String getAreaName() {
        return areaName;
    }

    public String getAreaCode() {
        return areaCode;
    }
}
