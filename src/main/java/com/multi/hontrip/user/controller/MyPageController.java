package com.multi.hontrip.user.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.user.dto.PageConditionDTO;
import com.multi.hontrip.user.dto.UserInfoDTO;
import com.multi.hontrip.user.service.MyPageService;
import com.multi.hontrip.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("user")
public class MyPageController { //마이페이지 관련 컨트롤러

    private final UserService userService;
    private final MyPageService myPageService;

    @GetMapping("my-page")
    @RequiredSessionCheck
    public ModelAndView myPageView(HttpSession session, ModelAndView modelAndView){  //마이페이지 - 세션 아이디로 사용자 정보 가져오기
        Long userId = (Long)session.getAttribute("id");
        UserInfoDTO userInfo = userService.getUserInfoBySessionId(userId);

        modelAndView.addObject("userInfo",userInfo);
        // 신규 댓글 내역 가져오기
        // 동행 신청 보기
        modelAndView.setViewName("/my-page/user-info");
        return modelAndView;
    }

    @GetMapping("reaccept-terms")
    @RequiredSessionCheck
    public RedirectView reacceptTerms(HttpSession session){// 재동의 - 카카오 싱크를 사용하지 않기 때문에 탈퇴시키고 가입 화면으로 보내야함
        Long userId = (Long)session.getAttribute("id");
        return new RedirectView(userService.reAcceptTerms(userId));
    }
    @GetMapping("refresh-userInfo")
    @RequiredSessionCheck
    public ResponseEntity<UserInfoDTO> refreshUserInfo(HttpSession session){
        Long userId = (Long)session.getAttribute("id");
        UserInfoDTO userInfoDTO = userService.refreshUserInfo(userId);
        //세션 정보 갱신
        session.setAttribute("nickName", userInfoDTO.getNickName());
        session.setAttribute("profileImage", userInfoDTO.getProfileImage());

        return ResponseEntity.ok(userInfoDTO);
    }

    @GetMapping("/my-record")
    @RequiredSessionCheck
    public ModelAndView myRecordPage(ModelAndView modelAndView,
                                     HttpSession session,
                                     PageConditionDTO pageConditionDTO){  //my-record 첫페이지
        Long userId = (Long)session.getAttribute("id");
        Map<String,Object> resultList = myPageService.getMyPageResult(userId,pageConditionDTO);

        resultList.forEach((key, value) -> {
            modelAndView.addObject(key, value);
        });
        modelAndView.setViewName("/my-page/my-record-page");
        return modelAndView;
    }

    @GetMapping("/my-record/condition")
    @RequiredSessionCheck
    public ResponseEntity<Map<String, Object>> myRecordPageSort(ModelAndView modelAndView,
                                                                HttpSession session,
                                                                PageConditionDTO pageConditionDTO){ //my-record,fetch 작동
        Long userId = (Long)session.getAttribute("id");
        Map<String,Object> resultList = myPageService.getMyPageResult(userId,pageConditionDTO);

        Map<String, Object> response = new HashMap<>();
        resultList.forEach((key,value)->{
            response.put(key,value);
        });
        return ResponseEntity.ok(response);
    }
}
