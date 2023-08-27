package com.multi.hontrip.mate.dao;

import com.multi.hontrip.mate.dto.AlarmPageDTO;
import com.multi.hontrip.mate.dto.MateMatchingAlarmDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AlarmDAO {

    @Autowired
    SqlSessionTemplate my;

    public int insertMatchingAlarm(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        return my.insert("mateBbs.insertMateMatchingAlarm", mateMatchingAlarmDTO);
    }

    public List<MateMatchingAlarmDTO> getAllAlarmByUserId(AlarmPageDTO alarmPageDTO) {
        return my.selectList("mateBbs.getAllAlarmByUserId", alarmPageDTO);
    }

    public int deleteByAlarmId(long alarmId) {
        return my.delete("mateBbs.deleteByAlarmId", alarmId);
    }

    public int countMateAllAlarms(long userId) {
        return my.selectOne("mateBbs.countMateAllAlarms", userId);
    }
}
