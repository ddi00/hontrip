package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.EmergencyFacilityDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class EmergencyFacilityDAO {
    @Autowired
    SqlSessionTemplate my;

    public EmergencyFacilityDTO one(Long EmergencyFacilityId) {
        return my.selectOne("emergency_facility.one", EmergencyFacilityId);
    }  // 일정 하나

    public List<EmergencyFacilityDTO> list() {
        return my.selectList("emergency_facility.all");
    }
}
