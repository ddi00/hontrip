package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dao.AlarmDAO;
import com.multi.hontrip.mate.dto.AlarmPageDTO;
import com.multi.hontrip.mate.dto.MateMatchingAlarmDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class AlarmServiceImpl implements AlarmService {

    private final AlarmDAO alarmDAO;

    //동행 신청 메세지 전송하기
    @Override
    public int insertMatchingAlarm(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        return alarmDAO.insertMatchingAlarm(mateMatchingAlarmDTO);
    }

    //동행인 매칭 알림 리스트 가져오기
    public List<MateMatchingAlarmDTO> getAllAlarmByUserId(AlarmPageDTO alarmPageDTO) {
        alarmPageDTO.setStartAlarmNum(alarmPageDTO.getCurrentPage());
        alarmPageDTO.setEndAlarmNum(alarmPageDTO.getCurrentPage(), alarmPageDTO.getAlarmNumPerPage());
        return alarmDAO.getAllAlarmByUserId(alarmPageDTO);
    }


    //동행인 매칭 알림 삭제
    public int deleteByAlarmId(long alarmId) {
        return alarmDAO.deleteByAlarmId(alarmId);
    }

    @Override
    public int countMateAllAlarms(long userId) {
        return alarmDAO.countMateAllAlarms(userId);
    }

    @Override
    public void readCheck(long alarmId) {
        alarmDAO.readCheck(alarmId);
    }
}
