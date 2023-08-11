package com.multi.hontrip.user.controller;

import com.multi.hontrip.user.dto.LoginUrlData;
import com.multi.hontrip.user.dto.UserDTO;
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
        //session에 id가 담겨져 있으면 원래 경로로 돌리기
        HttpSession session = request.getSession();
        if(session.getAttribute("id")!=null){
            return new ModelAndView("redirect:/");
        }

        //모델에 로그인할 수 있는 url을 담아서 전달 - 네이버, 구글, 카카오...
        List<LoginUrlData> loginUrls = userService.getUrls();
        modelAndView.addObject("urls",loginUrls);
        modelAndView.setViewName("/user/signInView");
        return modelAndView;
    }

    @GetMapping("/{provider}/callback")
    public String callback(@PathVariable("provider")String provider,
                                 HttpServletRequest request) throws Exception{   //Oauth 인증 callback  처리
        //인증 처리 - 네이버랑 카카오랑 callback값이 다름
        UserDTO member = userService.getUserInfByAuth(request,provider);

        //세션 처리
        HttpSession session = request.getSession();
        session.setAttribute("id",member.getId());
        session.setAttribute("nickName", member.getNickName());
        session.setAttribute("expireAt", member.getExpiresAt());
        session.setAttribute("refreshAt", member.getRefreshTokenExpiresAt());

        // TODO 이전 요청 경로로 이동
        String previousPath = "/";
        return "redirect:/";
    }
}
