package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.PlanDTO;

import java.util.List;

public interface PlanService {
    Long insert(PlanDTO planDTO); // 일정 생성

    void update(PlanDTO planDTO); // 일정 업데이트

    void delete(Long id); // 일정 삭제

    PlanDTO one(Long id); // id별 일정

    List<PlanDTO> list(); // 일정 리스트
}