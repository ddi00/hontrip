package com.multi.hontrip.mate.service;


import com.multi.hontrip.mate.dao.EmitterDAO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;

@Service
@RequiredArgsConstructor
public class NotificationService {

    private static final Long DEFAULT_TIMEOUT = 60L * 1000 * 60;

    private final EmitterDAO emitterDAO;

    public SseEmitter subscribe(long userId, String lastEventId) {
        String id = userId + "_" + System.currentTimeMillis();
        return new SseEmitter();
    }

    private void sendToClient(SseEmitter emitter, String id, Object data) {
        try {
            emitter.send(SseEmitter.event()
                    .id(id)
                    .name("sse")
                    .data(data));
        } catch (IOException exception) {
            /*emitterRepository.deleteById(id);*/
            throw new RuntimeException("연결 오류!");
        }
    }

}
