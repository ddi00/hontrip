package com.multi.hontrip.mate.alarm;

import com.multi.hontrip.mate.dao.AlarmDAO;
import com.multi.hontrip.mate.service.AlarmService;
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
    public List<MateMatchingAlarmDTO> getAllAlarmByUserId(long userId) {

        return null;
    }


    //동행인 매칭 알림 삭제
    public int deleteByAlarmId(long alarmId) {
        return 1;
    }
}
