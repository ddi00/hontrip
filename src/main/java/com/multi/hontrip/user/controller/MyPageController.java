package com.multi.hontrip.user.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.user.dto.MyRecordDTO;
import com.multi.hontrip.user.dto.PageDTO;
import com.multi.hontrip.user.dto.UserInfoDTO;
import com.multi.hontrip.user.service.MyPageService;
import com.multi.hontrip.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
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
    public ModelAndView myRecordPage(ModelAndView modelAndView,HttpSession session){
        Long userId = (Long)session.getAttribute("id");
        int totalCount = myPageService.getRecordTotalCount(userId);
        // 페이징 계산한 거 보내기
        PageDTO pageDTO = new PageDTO(totalCount);
        modelAndView.addObject("pageInfo",pageDTO);
        // 리스트 보내기
        List<MyRecordDTO> recordList = myPageService.getMyRecordList(pageDTO,userId);
        modelAndView.addObject("myRecordList",recordList);

        modelAndView.setViewName("/my-page/my-record-page");
        return modelAndView;
    }

    @GetMapping("/my-record/{page}")
    @RequiredSessionCheck
    public ResponseEntity<Map<String, Object>> myRecordSelectPage(HttpSession session, @PathVariable("page") int page) {
        Long userId = (Long) session.getAttribute("id");
        int totalCount = myPageService.getRecordTotalCount(userId);

        // 페이징 계산한 거 보내기
        PageDTO pageDTO = new PageDTO(totalCount, page);

        // 리스트 보내기
        List<MyRecordDTO> recordList = myPageService.getMyRecordList(pageDTO, userId);

        // JSON 응답 데이터 구성
        Map<String, Object> response = new HashMap<>();
        response.put("pageInfo", pageDTO);
        response.put("myRecordList", recordList);

        // ResponseEntity로 JSON 응답 반환
        return ResponseEntity.ok(response);
    }
}
