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
import java.util.Arrays;
import java.util.List;

@Service
public class PlanServiceImpl implements PlanService {
    private PlanDAO planDAO;
    private PlanDayDAO planDayDAO;
    private final SpotService spotService;
    private final FlightService flightService;
    private final AccommodationService accommodationService;

    @Autowired
    public PlanServiceImpl(PlanDAO planDAO, PlanDayDAO planDayDAO, SpotService spotService, FlightService flightService, AccommodationService accommodationService) {
        this.planDAO = planDAO;
        this.planDayDAO = planDayDAO;
        this.spotService = spotService;
        this.flightService = flightService;
        this.accommodationService = accommodationService;
    }

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
    public void deletePlan(Long planId, Long userId) {
        planDAO.delete(planId, userId);
    } // 일정 삭제

    @Override
    public PlanDTO findPlan(Long planId, Long userId) {
        return planDAO.one(planId, userId);
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
            planDayDTO.setPlanId(plan.getPlanId());
            planDayDTO.setUserId(plan.getUserId());
            planDayDTO.setDayOrder(i + 1);
            insertPlanDay(planDayDTO); // DB에 이미 존재하면 insert 되지 않음

            // 일정의 각 일차 가져옴
            PlanDayDTO planDayDTO2 = findPlanWithDay(plan.getPlanId(), plan.getUserId(), i + 1);
            try {
                if (!planDayDTO2.getSpotId().isEmpty()) { // 이미 추가된 여행지가 있을 경우
                    String existingSpots = planDayDTO2.getSpotId();
                    String[] SpotContentIds = existingSpots.split(":");  // ':'로 나눠진 spotContentId 분리
                    for (int j = 0; j < SpotContentIds.length; j++) {
                        SpotLoadDTO spotLoadDTO = new SpotLoadDTO(); // 일정-일차에 담긴 여행지 옮기기 위한 DTO
                        spotLoadDTO.setPlanId(plan.getPlanId());
                        spotLoadDTO.setUserId(plan.getUserId());
                        spotLoadDTO.setDayOrder(i + 1);
                        spotLoadDTO.setContentId(SpotContentIds[j]);
                        // 분리된 여행지 콘텐츠 id로 여행지명과 이미지 가져옴
                        SpotDTO spotDTO = spotService.findSpot(SpotContentIds[j]);
                        spotLoadDTO.setTitle(spotDTO.getTitle());
                        spotLoadDTO.setImage(spotDTO.getImage());
                        addedSpots.add(spotLoadDTO);
                    }
                } else {
                }
            } catch (NullPointerException e) {
            }
        }
        return addedSpots;
    } // 일정에 저장된 기존의 여행지 로드

    @Override
    public void addSpotToDay(Long planId, Long userId, int dayOrder, String spotContentId) {
        PlanDayDTO planDayDTO = findPlanWithDay(planId, userId, dayOrder);

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

        planDayDAO.updateSpot(planDayDTO);
    } // 일정-일차 여행지 정보 추가

    public SpotAddDTO createSpotAddDTO(Long planId, String spotContentId) {
        SpotDTO spotDTO = spotService.findSpot(spotContentId);

        SpotAddDTO spotAddDTO = new SpotAddDTO();
        spotAddDTO.setContentId(spotContentId);
        spotAddDTO.setTitle(spotDTO.getTitle());
        spotAddDTO.setImage(spotDTO.getImage());
        spotAddDTO.setPlanId(planId);

        return spotAddDTO;
    } // 추가 여행지 반환

    public void deleteSpotFromDay(Long planId, Long userId, int dayOrder, int spotOrder, String ContentId) {
        PlanDayDTO planDayDTO = findPlanWithDay(planId, userId, dayOrder);

        if (!planDayDTO.getSpotId().isEmpty()) {
            String existingSpots = planDayDTO.getSpotId();
            List<String> spotContentIds = new ArrayList<>(Arrays.asList(existingSpots.split(":"))); // ':'로 나눠진 spotContentId 분리
            spotContentIds.remove(spotOrder);
            if (spotContentIds.size() != 0) { // 삭제 후 남은 여행지가 있는 경우
                String[] spotContentArray = spotContentIds.toArray(new String[0]); // List<String> 을 다시 String 배열로 변환
                String newSpots = String.join(":", spotContentArray);
                planDayDTO.setSpotId(newSpots);
            } else { // 삭제 후 여행지가 남지 않는 경우
                planDayDTO.setSpotId("");
            }
        }
        planDayDAO.updateSpot(planDayDTO);
    } // 일정-일차 여행지 정보 삭제


    public List<FlightLoadDTO> loadExistingFlights(PlanDTO plan) {
        // 기존에 추가되어 있던 여행지 담을 리스트
        List<FlightLoadDTO> addedFlights = new ArrayList<>();

        PlanDayDTO planDayDTO = new PlanDayDTO(); // 일차 생성 위한 빈 DTO
        planDayDTO.setPlanId(plan.getPlanId());
        planDayDTO.setUserId(plan.getUserId());
        planDayDTO.setDayOrder(1);
        insertPlanDay(planDayDTO); // DB에 이미 존재하면 insert 되지 않음

        // 일차 가져옴
        PlanDayDTO planDayDTO2 = findPlanWithDay(plan.getPlanId(), plan.getUserId(), 1);
        try {
            if (!planDayDTO2.getFlightId().isEmpty()) { // 이미 추가된 항공권이 있을 경우
                String existingFlights = planDayDTO2.getFlightId();
                String[] FlightIds = existingFlights.split(":");  // ':'로 나눠진 spotContentId 분리
                for (int i = 0; i < FlightIds.length; i++) {
                    FlightLoadDTO flightLoadDTO = new FlightLoadDTO(); // 일정에 담긴 항공권 옮기기 위한 DTO
                    flightLoadDTO.setPlanId(plan.getPlanId());
                    flightLoadDTO.setUserId(plan.getUserId());
                    flightLoadDTO.setId(Long.valueOf(FlightIds[i]));
                    FlightDTO flightDTO = flightService.findFlight(Long.valueOf(FlightIds[i]));
                    flightLoadDTO.setVehicleId(flightDTO.getVehicleId());
                    flightLoadDTO.setAirlineName(flightDTO.getAirlineName());
                    flightLoadDTO.setDepAirportName(flightDTO.getDepAirportName());
                    flightLoadDTO.setDepartureTime(flightDTO.getDepartureTime());
                    flightLoadDTO.setArrAirportName(flightDTO.getArrAirportName());
                    flightLoadDTO.setArrivalTime(flightDTO.getArrivalTime());
                    addedFlights.add(flightLoadDTO);
                }
            } else {
            }
        } catch (NullPointerException e) {
        }
        return addedFlights;
    } // 일정에 저장된 기존의 항공권 로드


    @Override
    public void addFlightToDay(Long planId, Long userId, Long flightId) {
        PlanDayDTO planDayDTO = findPlanWithDay(planId, userId, 1);

        try {
            if (planDayDTO != null) {
                if (!planDayDTO.getFlightId().isEmpty()) {
                    String existingFlights = planDayDTO.getFlightId();
                    String newFlights = existingFlights + ":" + flightId; // 이미 존재하면 : 추가
                    planDayDTO.setFlightId(newFlights);
                } else {
                    planDayDTO.setFlightId(String.valueOf(flightId));
                }
            } else {
                PlanDayDTO newPlanDayDTO = new PlanDayDTO();
                newPlanDayDTO.setPlanId(planId);
                newPlanDayDTO.setUserId(userId);
                newPlanDayDTO.setDayOrder(1);
                newPlanDayDTO.setFlightId(String.valueOf(flightId));
            }
        } catch (NullPointerException e) {
            planDayDTO.setFlightId("");
            planDayDTO.setFlightId(String.valueOf(flightId));
        }

        planDayDAO.updateFlight(planDayDTO);
    } // 일정-일차 항공권 정보 추가

    public FlightAddDTO createFlightAddDTO(Long planId, Long flightId) {
        FlightDTO flightDTO = flightService.findFlight(flightId);

        FlightAddDTO flightAddDTO = new FlightAddDTO();
        flightAddDTO.setId(flightDTO.getId());
        flightAddDTO.setVehicleId(flightDTO.getVehicleId());
        flightAddDTO.setAirlineName(flightDTO.getAirlineName());
        flightAddDTO.setDepAirportName(flightDTO.getDepAirportName());
        flightAddDTO.setDepartureTime(flightDTO.getDepartureTime());
        flightAddDTO.setArrAirportName(flightDTO.getArrAirportName());
        flightAddDTO.setArrivalTime(flightDTO.getArrivalTime());
        flightAddDTO.setPlanId(planId);

        return flightAddDTO;
    } // 추가 항공권 반환

    public void deleteFlightFromDay(Long planId, Long userId, String flightId) {
        PlanDayDTO planDayDTO = findPlanWithDay(planId, userId, 1);

        if (!planDayDTO.getFlightId().isEmpty()) {
            String existingFlights = planDayDTO.getFlightId();
            List<String> flightIds = new ArrayList<>(Arrays.asList(existingFlights.split(":"))); // ':'로 나눠진 spotContentId 분리
            for (int i = flightIds.size() - 1; i >= 0; i--) {
                String id = flightIds.get(i);
                if (id.equals(flightId)) {
                    flightIds.remove(i);
                }
            }

            if (flightIds.size() != 0) { // 삭제 후 남은 항공권이 있는 경우
                String[] flightIdsArray = flightIds.toArray(new String[0]); // List<String> 을 다시 String 배열로 변환
                String newFlights = String.join(":", flightIdsArray);
                planDayDTO.setFlightId(newFlights);
            } else { // 삭제 후 항공권이 남지 않는 경우
                planDayDTO.setFlightId("");
            }
        }
        planDayDAO.updateFlight(planDayDTO);

    } // 일정-일차 항공권 정보 삭제

    @Override
    public List<AccommodationLoadDTO> loadExistingAccommodations(PlanDTO plan, int numOfDays) {
        List<AccommodationLoadDTO> addedAccommodations = new ArrayList<>();

        // Iterate through each day
        for (int i = 0; i < numOfDays; i++) {
            PlanDayDTO planDayDTO = new PlanDayDTO();
            planDayDTO.setPlanId(plan.getPlanId());
            planDayDTO.setUserId(plan.getUserId());
            planDayDTO.setDayOrder(i + 1);
            insertPlanDay(planDayDTO);

            // Fetch the plan-day
            PlanDayDTO existingPlanDay = findPlanWithDay(plan.getPlanId(), plan.getUserId(), i + 1);
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
        //AccommodationDTO accommodationDTO = accommodationService.one(accommodationId);
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
                System.out.println("when dayPlan already exists, planDayDTO != null");
                if (!planDayDTO.getAccommodationId().isEmpty()) {
                    String existingAccommodations = planDayDTO.getAccommodationId();
                    String newAccommodations = existingAccommodations + ":" + accommodationId;
                    planDayDTO.setAccommodationId(newAccommodations);

                } else {
                    planDayDTO.setAccommodationId(accommodationId);
                }
                // user_id, day_order 로 레코드가 존재하므로, update 를 해줘야 한다.
            } else {
                System.out.println("when planDayDTO===null");
                PlanDayDTO newPlanDayDTO = new PlanDayDTO();
                newPlanDayDTO.setPlanId(planId);
                newPlanDayDTO.setUserId(userId);
                newPlanDayDTO.setDayOrder(dayOrder);
                newPlanDayDTO.setAccommodationId(accommodationId);
                planDayDTO = newPlanDayDTO; // Set the created DTO back to planDayDTO
                // 해당 user_id 와 day_order 로 plantDTO 가 존재하지 않으니, insert 를 해줘야 한다.
            }
        } catch (NullPointerException e) {
            System.out.println("planDayDTO null exception");
            planDayDTO.setAccommodationId("");
            planDayDTO.setAccommodationId(accommodationId);
        }

        System.out.println("returning planDayDTO value : " + planDayDTO);
        addAccommodation(planDayDTO); // Call the method to update the plan-day
        return planDayDTO;
    }

    @Override
    public void addAccommodation(PlanDayDTO planDayDTO) {

        planDayDAO.updateAccommodation(planDayDTO);
        //planDayDAO.insert(planDayDTO);
        //System.out.println("before inserting planDayDTO : " + planDayDTO);
        //planDayDAO.insertWithNewAccommodation(planDayDTO);

    }
}
