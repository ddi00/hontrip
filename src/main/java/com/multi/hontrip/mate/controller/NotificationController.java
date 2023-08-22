/*
package com.multi.hontrip.mate.controller;

import com.multi.hontrip.mate.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Controller
@RequiredArgsConstructor
public class NotificationController {

    public static Map<String, SseEmitter> sseEmitters = new ConcurrentHashMap<>();

    private final NotificationService notificationService;
*/
/*
    public static Map<Long, SseEmitter> sseEmitterMap = new ConcurrentHashMap<>();

    //로그인한 유저를 알림서비스에 등록하는 과정
    //lastEventId는 서버가 유저에게 전송한 마지막 알림 id
    //lastEventId를 통해 전송하지 않은 알림들을 구분할 수 있다
    @GetMapping(value = "/sub/{userId}", produces = "text/event-stream")
    public SseEmitter subscribe(@PathVariable long userId,
                                @RequestHeader(value = "Last-Event-ID", required = false, defaultValue = "") String lastEventId) {
        return notificationService.subscribe(userId, lastEventId);
    }*//*


    @GetMapping("/practice")
    public String notiMain() {
        return "/mate/ssePrac";
    }

    */
/*@GetMapping(value = "/subscribe/{userId}", produces = "text/event-stream")
    public String subscribe(@PathVariable long userId,
                                @RequestHeader(value = "Last-Event-ID", required = false, defaultValue = "") String lastEventId, Model model) {
        SseEmitter sse = notificationService.subscribe(userId, lastEventId);
        model.addAttribute("sse2", sse);
        return "mate/ssePrac2";
    }*//*

 */
/* @GetMapping(value = "/subscribe/{userId}", produces = "text/event-stream")
    @ResponseBody
    public SseEmitter subscribe(@PathVariable long userId,
                                @RequestHeader(value = "Last-Event-ID", required = false, defaultValue = "") String lastEventId, Model model) {
       return notificationService.subscribe(userId, lastEventId);
    }


    @GetMapping("/sse")
    public void sse(final HttpServletResponse response) throws IOException, InterruptedException {
        response.setContentType("text/event-stream");
        response.setCharacterEncoding("UTF-8");

        Writer writer = response.getWriter();

        for (int i = 0; i < 20; i++) {
            writer.write("data: " + System.currentTimeMillis() + "\n\n");
            writer.flush(); // 꼭 flush 해주어야 한다.
            Thread.sleep(1000);
        }

        writer.close();
    }*//*


    @GetMapping(value = "/subscribe/{id}", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    @ResponseBody
    public SseEmitter subscribe(@PathVariable Long id) {
        return notificationService.subscribe(id);
    }

    @PostMapping("/send-data/{id}")
    @ResponseBody
    public void sendData(@PathVariable Long id) {
        notificationService.notify(id, "data");
    }
}
*/
