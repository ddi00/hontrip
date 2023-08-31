package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.EmergencyFacilityDTO;

import java.util.List;

public interface EmergencyFacilityService {

    void fetchAndSaveEmergencyFacilityData(String x, String y, int radius);

    EmergencyFacilityDTO one(Long emergencyFacilityId); // 응급시설 1개만 보기
    List<EmergencyFacilityDTO> list(); // 응급시설 리스트
    List<EmergencyFacilityDTO> filterByCategory(String categoryGroupName); // 응급시설 카테고리 필터 (병원|약국)
    List<EmergencyFacilityDTO> filterByAddress(String addressName); // 응급시설 주소 필터
    List<EmergencyFacilityDTO> filterByCategoryAndAddress(String categoryGroupName, String addressName); // 응급시설 주소|카테고리 필터
}