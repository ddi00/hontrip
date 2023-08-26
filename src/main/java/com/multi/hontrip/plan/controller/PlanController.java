package com.multi.hontrip.plan.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.plan.dto.*;
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

    @Autowired
    public PlanController(PlanService planService, SpotService spotService) {
        this.planService = planService;
        this.spotService = spotService;
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

        PlanDayDTO planDayDTO = planService.findPlanWithDay(planId, userId, dayOrder);
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

        // plan-day에 여행지 정보 추가
        planService.addSpot(planDayDTO);
        System.out.println("add success : " + planDayDTO);

        SpotDTO spotDTO = spotService.findSpot(spotContentId);
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