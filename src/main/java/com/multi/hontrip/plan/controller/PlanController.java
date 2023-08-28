package com.multi.hontrip.plan.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.plan.dto.*;
import com.multi.hontrip.plan.service.AccommodationService;
import com.multi.hontrip.plan.service.PlanService;
import com.multi.hontrip.plan.service.SpotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.xml.sax.SAXException;

import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/plan")
public class PlanController {
    private final PlanService planService;
    private final SpotService spotService;
    private final AccommodationService accommodationService;

    @Autowired
    public PlanController(PlanService planService, SpotService spotService, AccommodationService accommodationService) {
        this.planService = planService;
        this.spotService = spotService;
        this.accommodationService = accommodationService;
    }

    // 일정 생성
    @RequestMapping("/create")
    @RequiredSessionCheck
    public String showPlanForm(@ModelAttribute("planDTO") PlanDTO planDTO, HttpSession session) {
        session.getAttribute("id");
        return "/plan/create"; // 일정 생성 폼 반환
    }

    @PostMapping("/insert") // plan_form에서 작성한 내용 insert
    public String insert(@ModelAttribute("planDTO") PlanDTO planDTO, HttpSession session) {
        Long userId = (Long)session.getAttribute("id");
        planDTO.setUserId(userId);
        planService.insertPlan(planDTO);
        return "redirect:/plan/list"; // 일정 생성 후 일정 목록으로 리다이렉트
    }

    // 일정 수정
    @GetMapping("/detail")
    public String update(@RequestParam("planId") Long planId,
                         @ModelAttribute("planDTO") PlanDTO planDTO,
                         Model model, HttpSession session) {
        session.getAttribute("id");
        PlanDTO plan = planService.findPlan(planId); // 단일 일정 조회
        // 일차 계산
        int numOfDays = planService.calculateDays(plan.getStartDate(), plan.getEndDate());
        // 기존에 추가되어 있던 여행지 담을 리스트
        List<SpotLoadDTO> addedSpots = planService.loadExistingSpots(plan, numOfDays);

        model.addAttribute("addedSpots", addedSpots);
        model.addAttribute("numOfDays", numOfDays);
        model.addAttribute("plan", plan);
        return "/plan/edit"; // 일정 수정 폼
    }

    // 일정 수정 - 여행지 조회
    @RequestMapping("/detail/search-spot")
    public String searchSpot(@RequestParam("planId") Long planId,
                             @RequestParam("userId") Long userId,
                             @RequestParam("dayOrder") int dayOrder,
                             @RequestParam("category") String category,
                             @RequestParam("keyword") String keyword, Model model)
            throws ParserConfigurationException, SAXException, IOException {

        SpotSearchDTO spotSearchDTO = new SpotSearchDTO();
        spotSearchDTO.setCategory(category);
        spotSearchDTO.setKeyword(keyword);

        List<SpotDTO> spotList = spotService.searchSpots(spotSearchDTO); // 여행지 검색
        if(spotList.isEmpty()){
            model.addAttribute("message", "검색 결과가 없습니다."); // 검색 데이터 없는 경우 메시지 표시
        } else {
            model.addAttribute("list", spotList);
        }

        model.addAttribute("category", spotSearchDTO.getCategory());
        model.addAttribute("keyword", spotSearchDTO.getKeyword());
        model.addAttribute("dayOrder", dayOrder);

        return "/plan/spot/search_list_for_plan";
    }

    // 일정 수정 - 조회한 여행지 목록에서 추가한 여행지 id update
    @RequestMapping("/detail/update-plan-spot")
    @ResponseBody
    public SpotAddDTO updateSpot(@RequestParam("planId") Long planId,
                                 @RequestParam("userId") Long userId,
                                 @RequestParam("dayOrder") int dayOrder,
                                 @RequestParam("spotContentId") String spotContentId, Model model) {
        // plan-day에 여행지 정보 추가
        planService.addSpot(planService.addSpotToDay(planId, userId, dayOrder, spotContentId));
        System.out.println("add success");

        model.addAttribute("planId", planId);
        return planService.createSpotAddDTO(planId, spotContentId);
    }

    // 일정 수정 - 기존
//    @PostMapping("/update")
//    public String update(@ModelAttribute("planDTO") PlanDTO planDTO,
//                         @ModelAttribute("planDayDTO") PlanDayDTO planDayDTO) {
//        planService.update(planDTO);
//        return "redirect:/plan/list"; // 일정 수정 후 일정 목록으로 리다이렉트
//    }

    @RequestMapping(value = "detail/search-accommodation")
    public String filterAccommodationList(
            @RequestParam(name = "addressName", required = false) String addressName,
            @RequestParam(name = "placeName", required = false) String placeName,
            @RequestParam(name = "categoryName", required = false) String categoryName,
            @RequestParam(name = "filterType", required = false) String filterType,
            Model model
    ) {
        List<AccommodationDTO> list;

        if ("address_place".equals(filterType) && addressName != null && placeName != null) {
            list = accommodationService.filterByAddressAndPlaceName(addressName, placeName);
        } else if (addressName != null && categoryName != null) {
            list = accommodationService.filterByAddressAndCategoryName(addressName, categoryName);
        } else if ("address".equals(filterType) && addressName != null) {
            list = accommodationService.filterByAddress(addressName);
        } else if ("place_name".equals(filterType) && placeName != null) {
            list = accommodationService.filterByPlaceName(placeName);
        } else if (categoryName != null) {
            list = accommodationService.filterByCategory(categoryName);
        } else {
            list = accommodationService.list();
        }

        model.addAttribute("list", list);
        return "/plan/edit";
    }

    @RequestMapping("/detail/update-plan-accommodation")
    @ResponseBody
    public AccommodationAddDTO updateAccommodation(@RequestParam("planId") Long planId,
                                 @RequestParam("userId") Long userId,
                                 @RequestParam("dayOrder") int dayOrder,
                                 @RequestParam("accommodationId") String accommodationId, Model model) {
        // plan-day에 여행지 정보 추가
        planService.addAccommodation(planService.addAccommodationToDay(planId, userId, dayOrder, accommodationId));
        System.out.println("add success");

        model.addAttribute("planId", planId);
        return planService.createAccommodationAddDTO(planId, accommodationId);
    }

    // 일정 삭제
    @RequestMapping("/delete")
    @RequiredSessionCheck
    public String delete(Long planId) {
        planService.deletePlan(planId);
        return "redirect:/plan/list"; // 일정 삭제 후 일정 목록으로 리다이렉트
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
    @RequiredSessionCheck
    public String list(Model model, HttpSession session) {
        Long userId = (Long)session.getAttribute("id");
        List<PlanDTO> list = planService.findPlanList(userId);
        model.addAttribute("list", list);
        return "/plan/list";
    }
}