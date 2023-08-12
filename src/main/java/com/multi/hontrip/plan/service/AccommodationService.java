package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.AccommodationDTO;

import java.util.List;

public interface AccommodationService {
    AccommodationDTO one(Long accommodationId); // id별 일정
    List<AccommodationDTO> list(); // 일정 리스트
}
