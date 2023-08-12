package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.EmergencyFacilityDTO;
import com.multi.hontrip.plan.dao.EmergencyFacilityDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmergencyFacilityIdServiceImpl implements EmergencyFacilityService {
    @Autowired
    EmergencyFacilityDAO emergencyFacilityDAO;

    @Override
    public EmergencyFacilityDTO one(Long emergencyFacilityId) {
        return emergencyFacilityDAO.one(emergencyFacilityId);
    } // 일정 하나만 보기
    @Override
    public List<EmergencyFacilityDTO> list() {
        return emergencyFacilityDAO.list();
    } // 일정 list
}
