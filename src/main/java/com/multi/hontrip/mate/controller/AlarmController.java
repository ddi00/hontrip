package com.multi.hontrip.mate.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.mate.alarm.Message;
import com.multi.hontrip.mate.alarm.OutputMessage;
import com.multi.hontrip.mate.dto.AlarmPageDTO;
import com.multi.hontrip.mate.dto.AlarmPaginationDTO;
import com.multi.hontrip.mate.dto.MateMatchingAlarmDTO;
import com.multi.hontrip.mate.service.AlarmService;
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
    private final AlarmService alarmService;

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
    @ResponseBody
    public List<MateMatchingAlarmDTO> getAllAlarmByUserId(AlarmPageDTO alarmPageDTO, Model model, HttpSession session) {
        return alarmService.getAllAlarmByUserId(alarmPageDTO);
    }

    //알림 페이지네이션
    @GetMapping("/mate/alarm_page")
    @ResponseBody
    @RequiredSessionCheck
    public AlarmPaginationDTO alarmPagination(int currentPage,
                                              int alarmNumPerPage,
                                              int pageNumPerPagination, HttpSession session) {
        AlarmPaginationDTO alarmPaginationDTO = new AlarmPaginationDTO();
        alarmPaginationDTO.setOthers(alarmService.countMateAllAlarms((Long) session.getAttribute("id")),
                currentPage, alarmNumPerPage, pageNumPerPagination);
        return alarmPaginationDTO;
    }


    //동행인 매칭 알림 삭제
    @GetMapping("/mate/delete_alarm")
    @RequiredSessionCheck
    @ResponseBody
    public int deleteByAlarmId(long alarmId, HttpSession session) {
        return alarmService.deleteByAlarmId(alarmId);
    }

    //총 알람 개수 가져오기
    @GetMapping("/mate/alarm/total_count")
    @ResponseBody
    public int countMateAllAlarms(HttpSession session) {
        return alarmService.countMateAllAlarms((Long) session.getAttribute("id"));
    }
}
