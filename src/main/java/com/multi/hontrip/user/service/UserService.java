package com.multi.hontrip.user.service;

import com.multi.hontrip.user.dto.LoginUrlData;
import com.multi.hontrip.user.dto.UserDTO;
import com.multi.hontrip.user.dto.UserInfoDTO;
import com.multi.hontrip.user.dto.WithdrawUserDTO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface UserService {  //회원 관련 서비스
    List<LoginUrlData> getUrls(); //사용할 수 있는 url list 가져오기

    UserDTO getUserInfoByAuth(HttpServletRequest request, String provider) throws Exception;  //oauth 공급자의 인증을 통해 사용자 정보 처리

    String getUserLogOutUrl(Long id);   //id로 oauth공급자 검색해서 로그아웃 url 가져오기

    void logOut(Long userId);    //회원 로그아웃 처리

    WithdrawUserDTO getSoicalIdbyId(WithdrawUserDTO withdrawUserDTO);   //세션ID로 사용자 소셜 정보 가져오기

    String quiteSocial(WithdrawUserDTO withdrawUserDTO);    //사용자 소셜 정보 끊기

    void removeUserId(Long id); //DB에서 사용자 정보 제거

    UserInfoDTO getUserInfoBySessionId(Long userId);    //세션 아이디로 사용자 정보 가져오기
}
