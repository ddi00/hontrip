package com.multi.hontrip.mate.service;


import com.multi.hontrip.mate.dao.EmitterDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@Service
@RequiredArgsConstructor
public class NotificationService {

    private static final Long DEFAULT_TIMEOUT = 60L * 1000 * 60;

    private final EmitterDAO emitterDAO;

    public SseEmitter subscribe(long userId, String lastEventId) {
        String id = userId + "_" + System.currentTimeMillis();
        return new SseEmitter();
    }
}
