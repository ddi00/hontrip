package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.*;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public interface PlanService {
    void insertPlan(PlanDTO planDTO); // 일정 생성

    void updatePlan(PlanDTO planDTO); // 일정 수정

    void deletePlan(Long planId, Long userId); // 일정 삭제

    PlanDTO findPlan(Long planId, Long userId); // 일정 단일 조회

    List<PlanDTO> findPlanList(Long userId); // 일정 목록 조회

    void insertPlanDay(PlanDayDTO planDayDTO); // 일정에 일차 추가

    List<PlanDayDTO> findPlanDays(Long planId, Long userId); // 일정의 모든 일차 조회

    PlanDayDTO findPlanWithDay(Long planId, Long userId, int dayOrder); // 일정의 일차 조회

    int calculateDays(LocalDate startDate, LocalDate endDate); // 일차 계산

    List<SpotLoadDTO> loadExistingSpots(PlanDTO plan, int numOfDays); // 일정에 저장된 기존의 여행지 로드

    void addSpotToDay(Long planId, Long userId, int dayOrder, String spotContentId); // 일정-일차 여행지 정보 추가

    SpotAddDTO createSpotAddDTO(Long planId, String spotContentId); // 추가 여행지 반환

    void deleteSpotFromDay(Long planId, Long userId, int dayOrder, int spotOrder, String spotContentId); // 일정-일차 여행지 정보 삭제

    List<FlightLoadDTO> loadExistingFlights(PlanDTO plan); // 일정에 저장된 기존의 항공권 로드

    void addFlightToDay(Long planId, Long userId, Long flightId); // 일정-일차 항공권 정보 추가

    FlightAddDTO createFlightAddDTO(Long planId, Long flightId); // 추가 항공권 반환

    void deleteFlightFromDay(Long planId, Long userId, String flightId); // 일정-일차 항공권 정보 삭제
}