package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.PlanDayDTO;

import java.sql.Date;
import java.util.List;

public interface PlanDayService {

    void insert(PlanDayDTO plandayDTO);

    // 특정 plan의 모든 days 찾기
    List<PlanDayDTO> findPlanDays(Long planId, Long userId);

    // 특정 plan의 특정 day 찾기
    PlanDayDTO findPlanWithDay(Long planId, Long userId, int dayOrder);

    // 일정-해당일에 여행지 정보 추가
    void addSpot(PlanDayDTO planDayDTO);

}