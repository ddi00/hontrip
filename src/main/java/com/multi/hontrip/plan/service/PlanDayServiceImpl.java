package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.PlanDayDAO;
import com.multi.hontrip.plan.dto.PlanDayDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class PlanDayServiceImpl implements PlanDayService{
    @Autowired
    PlanDayDAO planDayDAO;

    // 일정 초기 생성시 빈 plan-day 생성
    @Override
    public void insert(PlanDayDTO planDayDTO) {
        planDayDAO.insert(planDayDTO);
    }

    // 특정 plan의 모든 days 찾기
    @Override
    public List<PlanDayDTO> findPlanDays(Long planId, Long userId){
        return planDayDAO.findPlanDays(planId, userId);
    }

    // 특정 plan의 특정 day 찾기
    @Override
    public PlanDayDTO findPlanWithDay(Long planId, Long userId, int dayOrder){
        return planDayDAO.findDayWithDay(planId, userId, dayOrder);
    }

    @Override
    // 일정-해당일에 여행지 정보 추가
    public void addSpot(PlanDayDTO planDayDTO){
        planDayDAO.updateSpot(planDayDTO);
    }
}