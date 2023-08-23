package com.multi.hontrip.user.controller;

import com.multi.hontrip.user.dto.LoginUrlData;
import com.multi.hontrip.user.dto.UserDTO;
import com.multi.hontrip.user.dto.UserInfoDTO;
import com.multi.hontrip.user.dto.WithdrawUserDTO;
import com.multi.hontrip.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;

    @GetMapping("/sign-in")
    public ModelAndView signIn(HttpServletRequest request,ModelAndView modelAndView){  //소셜 로그인 페이지로 이동
        //모델에 로그인할 수 있는 url을 담아서 전달 - 네이버, 구글, 카카오...
        List<LoginUrlData> loginUrls = userService.getUrls();
        modelAndView.addObject("urls",loginUrls);
        modelAndView.setViewName("/user/signin-view");
        return modelAndView;
    }

    @GetMapping("/{provider}/callback")
    public String callback(@PathVariable("provider")String provider,
                           HttpServletRequest request) throws Exception{   //소셜 로그인 Oauth 인증 callback  처리
        //인증 처리 - 네이버랑 카카오랑 callback값이 다름
        UserDTO member = userService.getUserInfoByAuth(request,provider);

        //세션 처리
        HttpSession session = request.getSession();
        session.setAttribute("id",member.getId());
        session.setAttribute("nickName", member.getNickName());
        session.setAttribute("profileImage", member.getProfileImage());

        return "redirect:/"; // TODO 이전 요청 경로로 이동
    }

    @GetMapping("/logout")
    public String logOut(HttpSession session){  //소셜 logout처리 url 반환
        Long userId = (Long)session.getAttribute("id");
        return "redirect:"+userService.getUserLogOutUrl(userId);
    }

    @GetMapping("/{provider}/logout")
    public String oauthLogout(@PathVariable("provider")String provider,
                                 HttpSession session) throws Exception{   //Oauth 로그아웃 callback 처리 - 카카오는 이미 로그아웃 됨
        //DB에 accessToken지우기
        Long userId = (Long)session.getAttribute("id");
        userService.logOut(userId);

        //세션 만료시키기
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("withdraw")
    public String withdrawUser(HttpSession httpSession){    //소셜 사용자 탈퇴 처리
        WithdrawUserDTO withdrawUserDTO = WithdrawUserDTO.builder().id((Long)httpSession.getAttribute("id")).build();
        //사용자 소셜 아이디 가져오기
        withdrawUserDTO = userService.getSoicalIdbyId(withdrawUserDTO);
        //탈퇴 처리
        String result = userService.quiteSocial(withdrawUserDTO);
        //db 탈퇴 처리
        if(result.equals("success")) {
            userService.removeUserId(withdrawUserDTO.getId());
        } else if (result.equals("fail")) {
            throw new RuntimeException("탈퇴를 실패했습니다");
        }
        //세션 삭제
        httpSession.invalidate();
        return "redirect:/";
    }

    @GetMapping("my-page")
    public ModelAndView myPageView(HttpSession session,ModelAndView modelAndView){  //마이페이지 - 세션 아이디로 사용자 정보 가져오기
        Long userId = (Long)session.getAttribute("id");
        UserInfoDTO userInfo = userService.getUserInfoBySessionId(userId);
        modelAndView.setViewName("/user/my-page");
        modelAndView.addObject("userInfo",userInfo);
        return modelAndView;
    }
}
