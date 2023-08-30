package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.PlanDayDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Repository
public class PlanDayDAO {
    @Autowired
    SqlSessionTemplate my;

    // 일정 초기 생성시 빈 plan-day 생성, 이미 존재하면 insert 되지 않음
    public void insert(PlanDayDTO planDayDTO) {
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("planId", planDayDTO.getPlanId());
        paramMap.put("userId", planDayDTO.getUserId());
        paramMap.put("dayOrder", planDayDTO.getDayOrder());

        my.insert("planDay.insert", paramMap);
    }

    // 특정 plan의 days 찾기
    public List<PlanDayDTO> findPlanDays(Long planId, Long userId){
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("planId", planId);
        paramMap.put("userId", userId);

        return my.selectList("planDay.getPlanDays", paramMap);
    }

    // 특정 plan의 특정 day - dayOrder까지 찾기
    public PlanDayDTO findDayWithDay(Long planId, Long userId, int dayOrder){
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("planId", planId);
        paramMap.put("userId", userId);
        paramMap.put("dayOrder", dayOrder);

        return my.selectOne("planDay.getPlanWithDayOrder", paramMap);
    }

    // 일정-해당일에 여행지 정보 추가
    public void updateSpot(PlanDayDTO planDayDTO){
        // HashMap 으로 다중 parameter 전달
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("planId", planDayDTO.getPlanId());
        paramMap.put("userId", planDayDTO.getUserId());
        paramMap.put("dayOrder", planDayDTO.getDayOrder());
        paramMap.put("spotId", planDayDTO.getSpotId());

        my.update("planDay.updateSpot", paramMap);
    }

    // 일정-해당일에 항공편 정보 추가
     public void updateFlight(PlanDayDTO planDayDTO){
         // HashMap 으로 다중 parameter 전달
         Map<String, Object> paramMap = new HashMap<String, Object>();
         paramMap.put("planId", planDayDTO.getPlanId());
         paramMap.put("userId", planDayDTO.getUserId());
         paramMap.put("dayOrder", planDayDTO.getDayOrder());
         paramMap.put("flightId", planDayDTO.getFlightId());

         my.update("planDay.updateFlight", paramMap);
     }
}