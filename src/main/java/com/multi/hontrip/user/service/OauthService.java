package com.multi.hontrip.user.service;

import com.multi.hontrip.user.dto.*;

public interface OauthService { // Oauth Service 처리
    String getLoginUrl(); // provider에 따라 로그인 url 생성

    UserInsertDTO getOauthInfo(String code, String state);    // access 토큰을 받아옴

    UserInsertDTO getUserInfoWithToken(OauthTokenDTO tokenDTO); //acess토큰으로 유저정보 가져오기

    String getLogOutUrl();  // 로그아웃 url 가져오기

    String quiteSicalOauth(WithdrawUserDTO withdrawUserDTO);    // 소셜-서비스 끊기

    String reAcceptTerms(UserSocialInfoDTO userSocialInfoDTO); // 재동의 받기

    UserInsertDTO refreshUserInfo(UserSocialInfoDTO userSocialInfo);  //사용자 정보 갱신
}
