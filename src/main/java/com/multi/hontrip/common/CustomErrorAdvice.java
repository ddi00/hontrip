package com.multi.hontrip.common;

import com.multi.hontrip.exception.AlreadySessionExistException;
import com.multi.hontrip.exception.SessionExpiredException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class CustomErrorAdvice {    //에러 전역처리 
    @ExceptionHandler(SessionExpiredException.class)
    public String handleSessionExpiredException(SessionExpiredException ex, RedirectAttributes redirectAttributes){ // session에러 처리
        redirectAttributes.addFlashAttribute("message",ex.getMessage());
        return "redirect:/user/sign-in";
    }

    @ExceptionHandler(AlreadySessionExistException.class)
    public String handleAlreadySessionExistException(AlreadySessionExistException ex){
        return "redirect:/";
    }
}
