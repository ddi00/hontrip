package com.multi.hontrip.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LoginUrlData { //사용자 로그인을 제공할 oauth 정보
    private String provider;    // oauth제공자
    private String loginHref;   // oauth로그인 경로
    private String imgSrc;  //oauth이미지 경로
}
