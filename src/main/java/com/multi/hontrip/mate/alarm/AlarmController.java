package com.multi.hontrip.mate.alarm;

import lombok.RequiredArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
@RequiredArgsConstructor
public class AlarmController {

    private final SimpMessageSendingOperations simpMessageSendingOperations;

    @GetMapping("/mate/alarm")
    public String stompAlarm() {
        return "/mate/mate_application_alarm";
    }

    @MessageMapping("/mate") //pub/mate
    public void send(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        simpMessageSendingOperations.convertAndSend("/sub/" + mateMatchingAlarmDTO.getReceiverId(), mateMatchingAlarmDTO);
    }

    @MessageMapping("/chat")
    @SendTo("/topic/messages")
    public OutputMessage send(Message message) throws Exception {
        String time = new SimpleDateFormat("HH:mm").format(new Date());
        return new OutputMessage(message.getFrom(), message.getText(), time);
    }
}
