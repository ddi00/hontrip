package com.multi.hontrip.mate.dao;

import com.multi.hontrip.mate.alarm.MateMatchingAlarmDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AlarmDAO {

    @Autowired
    SqlSessionTemplate my;

    public int insertMatchingAlarm(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        return my.insert("mateBbs.insertMateMatchingAlarm", mateMatchingAlarmDTO);
    }
}
