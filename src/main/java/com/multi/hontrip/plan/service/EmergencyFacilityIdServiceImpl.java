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
    public EmergencyFacilityDTO one(Long emergencyFacilityId) { // 응급시설 하나만 보기
        return emergencyFacilityDAO.one(emergencyFacilityId);
    }
    @Override
    public List<EmergencyFacilityDTO> list() {
        return emergencyFacilityDAO.list();
    } // 응급시설 리스트

    @Override
    public List<EmergencyFacilityDTO> filterByCategory(String categoryGroupName) { // 응급시설 카테고리 필터 (병원|약국)
        return emergencyFacilityDAO.filterByCategory(categoryGroupName);
    }

    @Override
    public List<EmergencyFacilityDTO> filterByAddress(String addressName) { // 응급시설 주소 필터
        return emergencyFacilityDAO.filterByAddress(addressName);
    }

    @Override
    public List<EmergencyFacilityDTO> filterByCategoryAndAddress(String categoryGroupName, String addressName) { // 응급시설 주소|카테고리 필터
        return emergencyFacilityDAO.filterByCategoryAndAddress(categoryGroupName, addressName);
    }
}
