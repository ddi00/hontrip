package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.EmergencyFacilityDTO;

import java.util.List;

public interface EmergencyFacilityService {
    EmergencyFacilityDTO one(Long emergencyFacilityId); // id별 일정
    List<EmergencyFacilityDTO> list(); // 일정 리스트
}