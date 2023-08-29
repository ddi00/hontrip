package com.multi.hontrip.common;

import com.multi.hontrip.exception.AlreadySessionExistException;
import com.multi.hontrip.exception.SessionExpiredException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class CustomErrorAdvice {    //에러 전역처리 
    @ExceptionHandler(SessionExpiredException.class)
    public String handleSessionExpiredException(SessionExpiredException ex, RedirectAttributes redirectAttributes){ // session에러 처리
        redirectAttributes.addFlashAttribute("message",ex.getMessage());
        return "redirect:/user/sign-in";
    }

    @ExceptionHandler(AlreadySessionExistException.class)
    public String handleAlreadySessionExistException(AlreadySessionExistException ex){  // 세션이 없어야할 영역에 세션이 있는 경우 에러처리
        return "redirect:/";
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    public String handleNoHandlerFoundException(NoHandlerFoundException ex, Model model) {  //404 페이지 not found 에러 처리
        String requestedPath = ex.getRequestURL(); // 사용자가 요청한 경로 가져오기
        model.addAttribute("requestedPath", requestedPath); // 모델에 에러 메시지 추가
        return "/error/404"; // 예외 처리 후 리다이렉트
    }

    @ExceptionHandler(Exception.class)
    public String handle500Error(Exception ex, Model model) {   //500 서버 에러 처리
        return "/error/500"; // 500 에러 페이지로 이동
    }
}
