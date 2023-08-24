package com.multi.hontrip.plan.controller;

import com.multi.hontrip.plan.dto.*;
import com.multi.hontrip.plan.service.PlanDayService;
import com.multi.hontrip.plan.service.PlanService;
import com.multi.hontrip.plan.service.SpotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/plan")
public class PlanController {
    private final PlanService planService;
    private final PlanDayService planDayService;
    private final SpotService spotService;

    @Autowired
    public PlanController(PlanService planService, PlanDayService planDayService, SpotService spotService) {
        this.planService = planService;
        this.planDayService = planDayService;
        this.spotService = spotService;
    }

    // 일정 생성
    @RequestMapping("/create")
    public String showPlanForm(@ModelAttribute("planDTO") PlanDTO planDTO) {
        return "/plan/create"; // 일정 생성 폼 반환
    }

    @PostMapping("/insert") // plan_form에서 작성한 내용 insert
    public String insert(@ModelAttribute("planDTO") PlanDTO planDTO) {
        // 사용자 ID 설정 (실제로는 세션 등에서 가져와야 함)
        planDTO.setUserId(1L);
        planService.insert(planDTO);
        return "redirect:/plan/list"; // 일정 생성 후 일정 목록으로 리다이렉트
    }

    // 일정 수정
    @GetMapping("/detail")
    public String Update(@RequestParam("planId") Long planId,
                            @ModelAttribute("planDTO") PlanDTO planDTO, Model model) {

        PlanDTO plan = planService.one(planId); // 단일 일정 조회
        Long userId = 1L; // 임시 userId

        // 일차 계산
        LocalDate startDate = plan.getStartDate();
        LocalDate endDate = plan.getEndDate();
        int numOfDays = (int) (ChronoUnit.DAYS.between(startDate, endDate) + 1);

        // 기존에 추가되어 있던 여행지 담을 리스트
        List<SpotLoadDTO> addedSpots = new ArrayList<>();

        // 여행일만큼 plan-day 생성
        for (int i = 0; i < numOfDays; i++) {
            PlanDayDTO planDayDTO = new PlanDayDTO();
            planDayDTO.setPlanId(plan.getId());
            planDayDTO.setUserId(plan.getUserId());
            planDayDTO.setDayOrder(i + 1);
            planDayService.insert(planDayDTO); // DB에 이미 존재하면 insert 되지 않음

            // 일정의 각 일차 가져옴
            PlanDayDTO planDayDTO2 = planDayService.findPlanWithDay(plan.getId(), plan.getUserId(), i + 1);
            System.out.println("planDayDTO2 : " + planDayDTO2);
            try {
                if (planDayDTO2 != null) {
                    if (!planDayDTO2.getSpotId().isEmpty()) {
                        String existingSpots = planDayDTO2.getSpotId();
                        String[] SpotContentIds = existingSpots.split(":");  // ':'로 나눠진 spotContentId 분리
                        for (int j = 0; j < SpotContentIds.length; j++) {
                            SpotLoadDTO spotLoadDTO = new SpotLoadDTO(); // 일정-일차에 담긴 여행지 옮기기 위한 DTO
                            spotLoadDTO.setPlanId(plan.getId());
                            spotLoadDTO.setUserId(plan.getUserId());
                            spotLoadDTO.setDayOrder(i + 1);
                            spotLoadDTO.setContentId(SpotContentIds[j]);
                            SpotDTO spotDTO = spotService.one(SpotContentIds[j]);
                            spotLoadDTO.setTitle(spotDTO.getTitle());
                            spotLoadDTO.setImage(spotDTO.getImage());
                            addedSpots.add(spotLoadDTO);
                        }
                    } else {

                    }
                }
            }catch (NullPointerException e){

            }
        }
        System.out.println(addedSpots);
        model.addAttribute("addedSpots", addedSpots);
        model.addAttribute("numOfDays", numOfDays);
        model.addAttribute("plan", plan);
        return "/plan/edit"; // 일정 수정 폼
    }

    // 일정 수정 - 여행지 조회
    @RequestMapping("/detail/search-spot")
    public String searchSpot(@RequestParam("planId") Long planId,
                             @RequestParam("userId") Long userId,
                             @RequestParam("startDate") String startDate,
                             @RequestParam("dayOrder") int dayOrder,
                             @RequestParam("category") String category,
                             @RequestParam("keyword") String keyword, Model model)
            throws ParserConfigurationException, SAXException, IOException {

        SpotSearchDTO spotSearchDTO = new SpotSearchDTO();
        spotSearchDTO.setCategory(category);
        spotSearchDTO.setKeyword(keyword);

        // 사용자 검색 범주에 따라 키워드 검색 / 지역 검색으로 분기
        if (spotSearchDTO.getCategory().equals("keyword")) {
            // api 호출하여 키워드로 여행지 조회
            spotService.parseData(spotSearchDTO);
            // DB에서 조건에 맞는 데이터 select
            List<SpotDTO> spotList = spotService.list(spotSearchDTO);
            // 검색 데이터 없는 경우 메시지 표시
            if (spotList.isEmpty()) {
                model.addAttribute("message", "검색 결과가 없습니다.");
            }
            model.addAttribute("list", spotList);

        } else if (spotSearchDTO.getCategory().equals("area")) {
            // api 호출하여 지역명으로 여행지 조회
            spotService.parseData(spotSearchDTO);
            // DB에서 조건에 맞는 데이터 select
            List<SpotDTO> spotList = spotService.list(spotSearchDTO);
            // 검색 데이터 없는 경우 메시지 표시
            if (spotList.isEmpty()) {
                model.addAttribute("message", "검색 결과가 없습니다.");
            }
            model.addAttribute("list", spotList);
        }

        model.addAttribute("category", spotSearchDTO.getCategory());
        model.addAttribute("keyword", spotSearchDTO.getKeyword());
        model.addAttribute("dayOrder", dayOrder);

        return "/plan/spot/search_list_for_plan";
    }

    // 조회한 여행지 목록에서 추가한 여행지 id update
    @RequestMapping("/detail/update-plan-spot")
    @ResponseBody
    public SpotAddDTO updateSpot(@RequestParam("planId") Long planId,
                                 @RequestParam("userId") Long userId,
                                 @RequestParam("dayOrder") int dayOrder,
                                 @RequestParam("spotContentId") String spotContentId, Model model) {

        PlanDayDTO planDayDTO = planDayService.findPlanWithDay(planId, userId, dayOrder);
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

        // plan-day에 여행지 정보 추가
        planDayService.addSpot(planDayDTO);

        SpotDTO spotDTO = spotService.one(spotContentId);
        SpotAddDTO spotAddDTO = new SpotAddDTO();
        spotAddDTO.setContentId(spotContentId);
        spotAddDTO.setTitle(spotDTO.getTitle());
        spotAddDTO.setImage(spotDTO.getImage());
        spotAddDTO.setPlanId(planId);

        model.addAttribute("planId", planId);
        return spotAddDTO;
    }

    // 일정 수정 - 기존
//    @PostMapping("/update")
//    public String update(@ModelAttribute("planDTO") PlanDTO planDTO,
//                         @ModelAttribute("planDayDTO") PlanDayDTO planDayDTO) {
//        planService.update(planDTO);
//        return "redirect:/plan/list"; // 일정 수정 후 일정 목록으로 리다이렉트
//    }

    // 일정 삭제
    @RequestMapping("/delete")
    public String delete(Long planId) {
        planService.delete(planId);
        return "redirect:/plan/list";  // 일정 삭제 후 일정 목록으로 리다이렉트
    }

    // 일정 상세 조회 - 기존
//    @RequestMapping("/detail")
//    public String one(@RequestParam("planId") Long planId, Model model) {
//        PlanDTO planDTO = planService.one(planId);
//        model.addAttribute("plan", planDTO);
//        return "/plan/detail";
//    }

    // 일정 목록 보기
    @RequestMapping("/list")
    public String list(Model model) {
        Long userId = 1L; // 임시
        List<PlanDTO> list = planService.list(userId);
        model.addAttribute("list", list);
        return "/plan/list";
    }
}