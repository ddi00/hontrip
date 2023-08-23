package com.multi.hontrip.mate.dto;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
public enum Region {
    SEOUL(1, "서울"),
    GANGWONDO(2, "강원도"),
    JEJU(3, "제주"),
    BUSAN(4, "부산"),
    GYEONGGIDO(5, "경기도"),
    INCHEON(6, "인천"),
    CHUNGCHEONGDO(7, "충청도"),
    GYEONGSANGDO(8, "경상도"),
    JEOLLADO(9, "전라도"),
    ULLEUNGDO(10, "울릉도");

    private final int regionNum;
    private final String regionStr;

    public int getRegionNum() {
        return regionNum;
    }

    public String getRegionStr() {
        return regionStr;
    }
}
