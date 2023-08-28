package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.PlanDAO;
import com.multi.hontrip.plan.dao.PlanDayDAO;
import com.multi.hontrip.plan.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

@Service
public class PlanServiceImpl implements PlanService{
    private PlanDAO planDAO;
    private PlanDayDAO planDayDAO;

    private final SpotService spotService;

    private final AccommodationService accommodationService;

    @Autowired
    public  PlanServiceImpl(PlanDAO planDAO, PlanDayDAO planDayDAO, SpotService spotService, AccommodationService accommodationService){
        this.planDAO = planDAO;
        this.planDayDAO = planDayDAO;
        this.spotService = spotService;
        this.accommodationService = accommodationService;
    };

    @Transactional
    @Override
    public void insertPlan(PlanDTO planDTO) {
        planDAO.insert(planDTO);
    } // 일정 생성

    @Override
    public void updatePlan(PlanDTO planDTO) {
        planDAO.update(planDTO);
    } // 일정 수정

    @Override
    public void deletePlan(Long planId) {
        planDAO.delete(planId);
    } // 일정 삭제

    @Override
    public PlanDTO findPlan(Long planId) {
        return planDAO.one(planId);
    } // 일정 단일 조회

    @Override
    public List<PlanDTO> findPlanList(Long userId) {
        return planDAO.list(userId);
    } // 일정 목록 조회

    @Override
    public void insertPlanDay(PlanDayDTO planDayDTO) {
        planDayDAO.insert(planDayDTO);
    } // 일정에 일차 추가 - 일정 초기 생성시 빈 plan-day 생성

    @Override
    public List<PlanDayDTO> findPlanDays(Long planId, Long userId) {
        return planDayDAO.findPlanDays(planId, userId);
    } // 일정의 모든 일차 조회

    @Override
    public PlanDayDTO findPlanWithDay(Long planId, Long userId, int dayOrder) {
        return planDayDAO.findDayWithDay(planId, userId, dayOrder);
    } // 일정의 일차 조회

    @Override
    public int calculateDays(LocalDate startDate, LocalDate endDate) {
        int numOfDays = (int) (ChronoUnit.DAYS.between(startDate, endDate) + 1);
        return numOfDays;
    } // 일차 계산

    public List<SpotLoadDTO> loadExistingSpots(PlanDTO plan, int numOfDays) {
        // 기존에 추가되어 있던 여행지 담을 리스트
        List<SpotLoadDTO> addedSpots = new ArrayList<>();

        // 여행일만큼 plan-day 생성
        for (int i = 0; i < numOfDays; i++) {
            PlanDayDTO planDayDTO = new PlanDayDTO(); // 일차 생성 위한 빈 DTO
            planDayDTO.setPlanId(plan.getId());
            planDayDTO.setUserId(plan.getUserId());
            planDayDTO.setDayOrder(i + 1);
            insertPlanDay(planDayDTO); // DB에 이미 존재하면 insert 되지 않음

            // 일정의 각 일차 가져옴
            PlanDayDTO planDayDTO2 = findPlanWithDay(plan.getId(), plan.getUserId(), i + 1);
            try {
//                if (planDayDTO2 != null) {
                    if (!planDayDTO2.getSpotId().isEmpty()) { // 이미 추가된 여행지가 있을 경우
                        String existingSpots = planDayDTO2.getSpotId();
                        String[] SpotContentIds = existingSpots.split(":");  // ':'로 나눠진 spotContentId 분리
                        for (int j = 0; j < SpotContentIds.length; j++) {
                            SpotLoadDTO spotLoadDTO = new SpotLoadDTO(); // 일정-일차에 담긴 여행지 옮기기 위한 DTO
                            spotLoadDTO.setPlanId(plan.getId());
                            spotLoadDTO.setUserId(plan.getUserId());
                            spotLoadDTO.setDayOrder(i + 1);
                            spotLoadDTO.setContentId(SpotContentIds[j]);
                            // 분리된 여행지 콘텐츠 id로 여행지명과 이미지 가져옴
                            SpotDTO spotDTO = spotService.findSpot(SpotContentIds[j]);
                            spotLoadDTO.setTitle(spotDTO.getTitle());
                            spotLoadDTO.setImage(spotDTO.getImage());
                            addedSpots.add(spotLoadDTO);
                        }
                    } else {}
            }catch (NullPointerException e){}
        }
        return addedSpots;
    } // 일정에 저장된 기존의 여행지 로드

    public SpotAddDTO createSpotAddDTO(Long planId, String spotContentId) {
        SpotDTO spotDTO = spotService.findSpot(spotContentId);

        SpotAddDTO spotAddDTO = new SpotAddDTO();
        spotAddDTO.setContentId(spotContentId);
        spotAddDTO.setTitle(spotDTO.getTitle());
        spotAddDTO.setImage(spotDTO.getImage());
        spotAddDTO.setPlanId(planId);

        return spotAddDTO;
    } // 추가 여행지 반환

    @Override
    public PlanDayDTO addSpotToDay(Long planId, Long userId, int dayOrder, String spotContentId) {
        PlanDayDTO planDayDTO = findPlanWithDay(planId, userId, dayOrder);
        System.out.println("update-plan-spot : " + planDayDTO);
        try {
            if (planDayDTO != null) {
                if (!planDayDTO.getSpotId().isEmpty()) {
                    String existingSpots = planDayDTO.getSpotId();
                    String newSpots = existingSpots + ":" + spotContentId; // 이미 존재하면 : 추가
                    planDayDTO.setSpotId(newSpots);
                } else {
                    planDayDTO.setSpotId(spotContentId);
                }
            } else {
                PlanDayDTO newPlanDayDTO = new PlanDayDTO();
                newPlanDayDTO.setPlanId(planId);
                newPlanDayDTO.setUserId(userId);
                newPlanDayDTO.setDayOrder(dayOrder);
                newPlanDayDTO.setSpotId(spotContentId);
            }
        } catch (NullPointerException e) {
            planDayDTO.setSpotId("");
            planDayDTO.setSpotId(spotContentId);
        }

//        planDayDAO.updateSpot(planDayDTO);
        return planDayDTO;
    } // 일정-일차 여행지 정보 추가

    public void addSpot(PlanDayDTO planDayDTO){
        planDayDAO.updateSpot(planDayDTO);
    }

    @Override
    public List<AccommodationLoadDTO> loadExistingAccommodations(PlanDTO plan, int numOfDays) {
        List<AccommodationLoadDTO> addedAccommodations = new ArrayList<>();

        // Iterate through each day
        for (int i = 0; i < numOfDays; i++) {
            PlanDayDTO planDayDTO = new PlanDayDTO();
            planDayDTO.setPlanId(plan.getId());
            planDayDTO.setUserId(plan.getUserId());
            planDayDTO.setDayOrder(i + 1);
            insertPlanDay(planDayDTO);

            // Fetch the plan-day
            PlanDayDTO existingPlanDay = findPlanWithDay(plan.getId(), plan.getUserId(), i + 1);
            try {
                if (existingPlanDay != null && !existingPlanDay.getAccommodationId().isEmpty()) {
                    String existingAccommodations = existingPlanDay.getAccommodationId();
                    String[] AccommodationIds = existingAccommodations.split(":");
                    for (String accommodationId : AccommodationIds) {
                        AccommodationLoadDTO accommodationLoadDTO = new AccommodationLoadDTO();
                        // Set the necessary fields for accommodationLoadDTO using accommodationId
                        addedAccommodations.add(accommodationLoadDTO);
                    }
                }
            } catch (NullPointerException e) {
                // Handle null pointers if needed
            }
        }
        return addedAccommodations;
    }

    public AccommodationAddDTO createAccommodationAddDTO(Long planId, String accommodationId) {
        AccommodationDTO accommodationDTO = accommodationService.one(Long.parseLong(accommodationId));

        AccommodationAddDTO accommodationAddDTO = new AccommodationAddDTO();
        accommodationAddDTO.setAccommodationId(Long.valueOf(accommodationId));
        accommodationAddDTO.setPlaceName(accommodationDTO.getPlaceName());
        accommodationAddDTO.setPlanId(planId);

        return accommodationAddDTO;
    }

    @Override
    public PlanDayDTO addAccommodationToDay(Long planId, Long userId, int dayOrder, String accommodationId) {
        PlanDayDTO planDayDTO = findPlanWithDay(planId, userId, dayOrder);

        try {
            if (planDayDTO != null) {
                if (!planDayDTO.getAccommodationId().isEmpty()) {
                    String existingAccommodations = planDayDTO.getAccommodationId();
                    String newAccommodations = existingAccommodations + ":" + accommodationId;
                    planDayDTO.setAccommodationId(newAccommodations);
                } else {
                    planDayDTO.setAccommodationId(accommodationId);
                }
            } else {
                PlanDayDTO newPlanDayDTO = new PlanDayDTO();
                newPlanDayDTO.setPlanId(planId);
                newPlanDayDTO.setUserId(userId);
                newPlanDayDTO.setDayOrder(dayOrder);
                newPlanDayDTO.setAccommodationId(accommodationId);
                planDayDTO = newPlanDayDTO; // Set the created DTO back to planDayDTO
            }
        } catch (NullPointerException e) {
            planDayDTO.setAccommodationId("");
            planDayDTO.setAccommodationId(accommodationId);
        }

        addAccommodation(planDayDTO); // Call the method to update the plan-day
        return planDayDTO;
    }

    @Override
    public void addAccommodation(PlanDayDTO planDayDTO) {
        planDayDAO.updateAccommodation(planDayDTO);
    }
}
