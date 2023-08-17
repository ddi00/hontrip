package com.multi.hontrip.plan.parser;

// 항공편 조회 시 공항명 - 공항 id 맵핑 위한 enum class
public enum Airport {
    KIMPO ("김포", "NAARKSS"),
    INCHEON ("인천", "NAARKSI"),
    JEJU ("제주", "NAARKPC"),
    GIMHAE ("김해", "NAARKPK"),
    DAEGU ("대구", "NAARKTN"),
    CHEONGJU ("청주", "NAARKTU"),
    GWANGJU ("광주", "NAARKJJ"),
    POHANG ("포항", "NAARKTH"),
    YANGYANG ("양양", "NAARKNY"),
    WONJU ("원주", "NAARKNW"),
    YEOSU ("여수", "NAARKJY"),
    ULSAN ("울산", "NAARKPU"),
    SACHEON ("사천", "NAARKPS"),
    MUAN ("무안", "NAARKJB"),
    GUNSAN ("군산", "NAARKJK");

    private final String airportName; // 공항명
    private final String airportId; // 공항 ID

    Airport(String airportName, String airportId) {
        this.airportName = airportName;
        this.airportId = airportId;
    }

    public String getAirportName(){
        return this.airportName;
    }

    public String getAirportId() {
        return this.airportId;
    }
}
