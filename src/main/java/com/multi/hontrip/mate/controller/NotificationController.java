package com.multi.hontrip.mate.controller;

import com.multi.hontrip.mate.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
@RequiredArgsConstructor
public class NotificationController {

    private final NotificationService notificationService;

    public static Map<Long, SseEmitter> sseEmitterMap = new ConcurrentHashMap<>();

    //로그인한 유저를 알림서비스에 등록하는 과정
    //lastEventId는 서버가 유저에게 전송한 마지막 알림 id
    //lastEventId를 통해 전송하지 않은 알림들을 구분할 수 있다
    @GetMapping(value = "/sub/{userId}", produces = "text/event-stream")
    public SseEmitter subscribe(@PathVariable long userId,
                                @RequestHeader(value = "Last-Event-ID", required = false, defaultValue = "") String lastEventId) {
        return notificationService.subscribe(userId, lastEventId);
    }
}
