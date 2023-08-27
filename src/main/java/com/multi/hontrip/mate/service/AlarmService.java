package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dto.AlarmPageDTO;
import com.multi.hontrip.mate.dto.MateMatchingAlarmDTO;

import java.util.List;

public interface AlarmService {
    int insertMatchingAlarm(MateMatchingAlarmDTO mateMatchingAlarmDTO); //동행인 신청 알림 인서트

    List<MateMatchingAlarmDTO> getAllAlarmByUserId(AlarmPageDTO alarmPageDTO);   //유저의 동행인 신청 알림 모두 가져오기

    int deleteByAlarmId(long alarmId);  //동행인 신청 알림 삭제하기

    int countMateAllAlarms(long userId); //전체 동행신청 알람개수
}
