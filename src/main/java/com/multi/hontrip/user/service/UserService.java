package com.multi.hontrip.user.service;

import com.multi.hontrip.user.dto.LoginUrlData;
import com.multi.hontrip.user.dto.UserDTO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface UserService {  //회원 관련 서비스
    List<LoginUrlData> getUrls() ; //사용할 수 있는 url list 가져오기
    UserDTO getUserInfByAuth(HttpServletRequest request, String provider) throws Exception;  //oauth 공급자의 인증을 통해 사용자 정보 처리
    String getUserLogOutUrl(Long id);   //id로 oauth공급자 검색해서 로그아웃 url 가져오기 
    void logOut(Long userId);    //회원 로그아웃 처리
}
