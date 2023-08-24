package com.multi.hontrip.exception;

public class SessionExpiredException extends Throwable {    //세션 사용자 정의 에러
    public SessionExpiredException(String message) {
        super(message);
    }
}
