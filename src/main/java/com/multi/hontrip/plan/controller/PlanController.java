package com.multi.hontrip.plan.controller;

import com.multi.hontrip.plan.dto.PlanDTO;
import com.multi.hontrip.plan.service.PlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/plan")
public class PlanController {

    @Autowired
    PlanService planService;
    
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
    @GetMapping( "/update")
    public String getUpdate(PlanDTO planDTO, Model model) {
        model.addAttribute("plan", planService.one(planDTO.getId()));
        return "/plan/edit"; // 일정 수정 폼
    }

    @PostMapping("/update")
    public String update(PlanDTO planDTO) {
        planService.update(planDTO);
        return "redirect:/plan/list"; // 일정 수정 후 일정 목록으로 리다이렉트
    }


    // 일정 삭제
    @RequestMapping("/delete")
    public String delete(PlanDTO planDTO) {
        planService.delete(planDTO.getId());
        return "redirect:/plan/list";  // 일정 삭제 후 일정 목록으로 리다이렉트
    }

    // 일정 하나만 보기
    @RequestMapping("/detail")
    public String one(@RequestParam("id") Long id, Model model) {
        PlanDTO planDTO = planService.one(id);
        model.addAttribute("plan", planDTO);
        return "/plan/detail";
    }


    // 일정 목록 보기
    @RequestMapping("/list")
    public String list(Model model) {
        List<PlanDTO> list = planService.list();
        model.addAttribute("list", list);
        return "/plan/list";
    }

}