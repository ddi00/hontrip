package com.multi.hontrip.user.service;

import com.multi.hontrip.user.dto.OauthTokenDTO;
import com.multi.hontrip.user.dto.UserInsertDTO;
import com.multi.hontrip.user.dto.WithdrawUserDTO;

public interface OauthService { // Oauth Service 처리
    String getLoginUrl(); // provider에 따라 로그인 url 생성

    UserInsertDTO getOauthInfo(String code, String state);    // access 토큰을 받아옴

    UserInsertDTO getUserInfoWithToken(OauthTokenDTO tokenDTO); //acess토큰으로

    String getLogOutUrl();  // 로그아웃 url 가져오기

    String quiteSicalOauth(WithdrawUserDTO withdrawUserDTO);
}
