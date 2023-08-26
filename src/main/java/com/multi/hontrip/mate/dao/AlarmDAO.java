package com.multi.hontrip.mate.dao;

import com.multi.hontrip.mate.alarm.MateMatchingAlarmDTO;
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

    public List<MateMatchingAlarmDTO> getAllAlarmByUserId(long userId) {
        return my.selectList("mateBbs.getAllAlarmByUserId", userId);
    }

    public int deleteByAlarmId(long alarmId) {
        return my.delete("mateBbs.deleteByAlarmId", alarmId);
    }
}
