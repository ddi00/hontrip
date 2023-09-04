package com.multi.hontrip.user.controller;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.mate.service.MateService;
import com.multi.hontrip.user.dto.PageConditionDTO;
import com.multi.hontrip.user.dto.UserInfoDTO;
import com.multi.hontrip.user.service.MyPageService;
import com.multi.hontrip.user.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("user")
public class MyPageController { //마이페이지 관련 컨트롤러

    private final UserService userService;
    private final MyPageService myPageService;
    private final MateService mateService;

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
    @PostMapping("/my-record/deletePosts")
    @RequiredSessionCheck
    public ResponseEntity<String> deleteSelectList(ModelAndView modelAndView,
                                         HttpSession session,
                                         @RequestBody String ids){ //my-record,fetch 작동
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, List<Integer>> idMap = objectMapper.readValue(ids, new TypeReference<Map<String, List<Integer>>>() {
            });
            List<Integer> idList = idMap.get("ids");
            String responseData = "{\"message\": \"작업이 완료되었습니다.\"}";
            // idList를 사용하여 원하는 작업을 수행
            return new ResponseEntity<>(responseData, headers, HttpStatus.OK);
        } catch (IOException e) {
            String responseData = "{\"message\": \"삭제 작업이 실패했습니다.\"}";
            return new ResponseEntity<>(responseData, headers, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    /*@GetMapping("/my-mate")
    @RequiredSessionCheck
    public String myRecordPage(Model model, HttpSession session, MatePageDTO matePageDTO){  //my-record 첫페이지

        MatePageDTO pagedDTO = mateService.paging(matePageDTO);
        //게시물 리스트 가져오기
        List<MateBoardListDTO> list = mateService.list(pagedDTO);
        model.addAttribute("list", list);
        model.addAttribute("pageDTO", pagedDTO);

        *//*Long userId = (Long)session.getAttribute("id");
        Map<String,Object> resultList = myPageService.getMyPageResult(userId,pageConditionDTO);

        resultList.forEach((key, value) -> {
            modelAndView.addObject(key, value);
        });*//*
     *//*modelAndView.setViewName("/my-page/my-mate-page");*//*
        return "/my-page/my-mate-page";
    }*/
}
