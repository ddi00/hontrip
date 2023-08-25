package com.multi.hontrip.user.service;

import com.multi.hontrip.user.dao.UserDAO;
import com.multi.hontrip.user.dto.*;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService{   //사용자 회원처리

    private final UserDAO userDAO;
    @Qualifier("kakaoService")
    private final OauthService kakaoService;
    @Qualifier("naverService")
    private final OauthService naverService;

    @Override
    public List<LoginUrlData> getUrls(){   //로그인 가능한 소셜ouath주소 리스트로 저장
        List<LoginUrlData> urlList = new ArrayList<>();
        urlList.add(new LoginUrlData("kakao",kakaoService.getLoginUrl()+"&state=none","/resources/img/user/kakao_login_medium_narrow.png"));    //카카오
        urlList.add(new LoginUrlData("naver",naverService.getLoginUrl(),"/resources/img/user/btnG_완성형.png"));   //네이버
        return urlList;
    }

    @Override
    public UserDTO getUserInfoByAuth(HttpServletRequest request, String provider){ //소셜 인증정보를 통해 DB저장
        String code = request.getParameter("code");
        String state = request.getParameter("state");

        UserInsertDTO userInsertDTO = getUserInsertDTO(provider,code,state);

        //소셜 로그인 기반으로 기존 회원 여부 판단
        Long userId = userDAO.findIdByProviderAndSocialID(userInsertDTO.getProvider(),userInsertDTO.getSocialId());
        if(userId==null){ //db 신규저장
           userInsertDTO = userDAO.saveUserInfo(userInsertDTO); //신규 회원 저장
        }else{  //db 정보 갱신
            userInsertDTO.setId(userId);    //id 넣어서 해당 정보 update
            userDAO.updateUserInfo(userInsertDTO);  // update
        }
        return UserInsertDTO.convertToInsertUserDTO(userInsertDTO); // 세션에 넣을 정보 저장
    }

    private UserInsertDTO getUserInsertDTO(String provider, String code, String state) {    // provider에 따른 인증정보 가져오기
        if(provider.equals("kakao")){
            return kakaoService.getOauthInfo(code,state);  //카카오 인증 받아오기
        }else if(provider.equals("naver")){
            return naverService.getOauthInfo(code,state);
        }else {
            throw new IllegalArgumentException("지원하지 않는 소셜 프로바이더 입니다");
        }
    }

    @Override
    public void logOut(Long userId) {   //로그아웃시 사용자 access 토큰 관련 정보 지우기
        userDAO.removeAccessToken(userId);
    }

    @Override
    public WithdrawUserDTO getSoicalIdbyId(WithdrawUserDTO withdrawUserDTO) {   //사용자 정보 가져오기
        return userDAO.findSocialInfoById(withdrawUserDTO.getId());
    }

    @Override
    public String quiteSocial(WithdrawUserDTO withdrawUserDTO) {    //소셜 탈퇴 처리 - 사용자 구분
        if(withdrawUserDTO.getProvider().equals("kakao")){  
            return kakaoService.quiteSicalOauth(withdrawUserDTO);
        }else if(withdrawUserDTO.getProvider().equals("naver")){
            return naverService.quiteSicalOauth(withdrawUserDTO);
        }
        return "fail";
    }

    @Override
    public void removeUserId(Long id) { //DB에서 사용자 정보 삭제
        userDAO.removeUser(id);
    }

    @Override
    public UserInfoDTO getUserInfoBySessionId(Long userId) {    //세션아이디로 회원정보 가져오기
        UserInsertDTO userDTO = userDAO.getUserInfoBySessionId(userId);
        return UserInfoDTO.convertFromUserDTO(userDTO);
    }

    @Override
    public String reAcceptTerms(Long userId) { // 재동의 받기
        UserSocialInfoDTO userSocialInfo = userDAO.getSocialInfoById(userId);  // 공급자 검색
        if(userSocialInfo.getProvider().equals("kakao")) {  // 카카오만 필수동의랑 선택동의가 나누어져 있음
            return kakaoService.reAcceptTerms(userSocialInfo);   // 탈퇴시키고 재가입 시키기 - 재가입 시킬 url을 반환
        }
        return null;
    }

    @Override
    public UserInfoDTO refreshUserInfo(Long userId) {
        UserSocialInfoDTO userSocialInfo = userDAO.getSocialInfoById(userId);  // 공급자 검색
        UserInsertDTO userInsertDTO;
        if(userSocialInfo.getProvider().equals("kakao")) {  // 카카오만 필수동의랑 선택동의가 나누어져 있음
            userInsertDTO = kakaoService.refreshUserInfo(userSocialInfo);   // 탈퇴시키고 재가입 시키기 - 재가입 시킬 url을 반환
        }else if(userSocialInfo.getProvider().equals("naver")){
            userInsertDTO = naverService.refreshUserInfo(userSocialInfo);
        }else {
            throw new IllegalArgumentException("지원하지 않는 소셜 프로바이더 입니다");
        }
        //DB정보 저장
        userInsertDTO.setId(userId);    //id 넣어서 해당 정보 update
        userDAO.updateUserInfo(userInsertDTO);  // update

        return UserInfoDTO.convertFromUserDTO(userInsertDTO);
    }

    @Override
    public String getUserLogOutUrl(Long id) {       // id로 공급자 검색해서 로그아웃 url 반환
        String provider = userDAO.getProviderById(id);  // 공급자 검색
        if(provider.equals("kakao")) {
            return kakaoService.getLogOutUrl();   // kakao 로그아웃 url 반환
        }else if(provider.equals("naver")){
            return naverService.getLogOutUrl();
        }
        return "/";
    }
}
