package com.multi.hontrip.mate.alarm;

import com.multi.hontrip.common.RequiredSessionCheck;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class AlarmController {

    private final SimpMessageSendingOperations simpMessageSendingOperations;
    private final AlarmServiceImpl alarmService;

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


    //db에 동행 신청 알림 넣기
    @PostMapping("/mate/insertMatchingAlarm")
    @ResponseBody
    public int insertMatchingAlarm(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        return alarmService.insertMatchingAlarm(mateMatchingAlarmDTO);
    }

    //동행인 매칭 알림 리스트 가져오기
    @GetMapping("/mate/alarm_list")
    @RequiredSessionCheck
    public String getAllAlarmByUserId(Model model, HttpSession session) {
        long userId = (long) session.getAttribute("id");
        List<MateMatchingAlarmDTO> alarmList = alarmService.getAllAlarmByUserId(userId);
        model.addAttribute("alarmList", alarmList);
        return "/mate/mate_application_alarm";
    }


    //동행인 매칭 알림 삭제
    @GetMapping("/mate/delete_alarm")
    public int deleteByAlarmId(long alarmId) {
        return alarmService.deleteByAlarmId(alarmId);
    }
}
