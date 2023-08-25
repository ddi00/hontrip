package com.multi.hontrip.common;

import com.multi.hontrip.exception.AlreadySessionExistException;
import com.multi.hontrip.exception.SessionExpiredException;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;

@Aspect
@Component
public class SessionCheckAdvice {

    @Before("@annotation(RequiredSessionCheck)") // @RequiredSessionCheck 어노테이션이 붙은 메서드 실행 전에 실행
    public void checkSession(JoinPoint joinPoint) throws SessionExpiredException {
        //JoinPoint를 통해 메서드에 전달된 파라미터 중 HttpSession을 가져옵니다.
        Object[] args = joinPoint.getArgs();
        HttpSession session = null;

        for (Object arg : args) {   //argument에 Session 있어야 함
            if (arg instanceof HttpSession) {
                session = (HttpSession) arg;
                break;
            }
        }
        if (session == null || session.getAttribute("id") == null) {// HttpSession 검사
            throw new SessionExpiredException("로그인되어 있지 않습니다.");
        }
    }

    @Before("@annotation(NoSessionRequired)")
    public void checkNoSession(JoinPoint joinPoint) throws AlreadySessionExistException {
        Object[] args = joinPoint.getArgs();
        HttpSession session = null;

        for (Object arg : args) {   //argument에 Session 있어야 함
            if (arg instanceof HttpSession) {
                session = (HttpSession) arg;
                break;
            }
        }
        if (session != null) {
            Object userId = session.getAttribute("id");
            if (userId != null) {
                throw new AlreadySessionExistException("이미 로그인한 사용자입니다.");
            }
        }
    }

}
