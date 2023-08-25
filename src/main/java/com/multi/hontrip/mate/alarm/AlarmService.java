package com.multi.hontrip.mate.alarm;

import java.util.List;

public interface AlarmService {
    int insertMatchingAlarm(MateMatchingAlarmDTO mateMatchingAlarmDTO); //동행인 신청 알림 인서트

    List<MateMatchingAlarmDTO> getAllAlarmByUserId(long userId);   //유저의 동행인 신청 알림 모두 가져오기

    int deleteByAlarmId(long alarmId);  //동행인 신청 알림 삭제하기
}
