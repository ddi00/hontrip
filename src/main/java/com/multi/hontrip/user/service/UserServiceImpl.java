package com.multi.hontrip.user.service;

import com.multi.hontrip.user.dao.UserDAO;
import com.multi.hontrip.user.dto.LoginUrlData;
import com.multi.hontrip.user.dto.UserDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements  UserService{

    private final UserDAO userDAO;
    private final KakaoService kakaoService;

    @Override
    public List<LoginUrlData> getUrls() {
        List<LoginUrlData> urlList = new ArrayList<>();
        urlList.add(new LoginUrlData("kakao",kakaoService.getKakaoLogin(),"/resources/img/user/kakao_login_medium_narrow.png"));
        return urlList;
    }

    @Override
    public UserDTO getUserInfByAuth(HttpServletRequest request, String provider) throws Exception {
        UserDTO member = null;

        if(provider.equals("kakao")){
            System.out.println(request.getParameter("code"));
            member=kakaoService.getKakaoInfo(request.getParameter("code"));
        }

        // 기존 회원 판별
        Long userId = userDAO.findIdByProviderAndSocialID(member.getProvider(),member.getSocialId());
        if(userId==null){ //db 신규저장

            userDAO.saveUserInfo(member);
        }else{  //db 정보 갱신

            userDAO.updateUserInfo(member);
        }
        return member;
    }
}
