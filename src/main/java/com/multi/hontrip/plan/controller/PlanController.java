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
    @GetMapping("/create")
    public String showPlanForm(@ModelAttribute("planDTO") PlanDTO planDTO) {
        return "/plan/create"; // 일정 생성 폼 반환
    }


//    @PostMapping("insert") // plan_form에서 작성한 내용 insert
//    public String insert(@ModelAttribute("planDTO") PlanDTO planDTO) {
//        // 사용자 ID 설정 (실제로는 세션 등에서 가져와야 함)
//        planDTO.setUserId(1L);
//        planService.insert(planDTO);
//        return "redirect:/plan/list"; // 일정 생성 후 일정 목록으로 리다이렉트
//    }

    @PostMapping("/insert")
    public String insert(@ModelAttribute("planDTO") PlanDTO planDTO, Model model) {
        // 사용자 ID 설정 (실제로는 세션 등에서 가져와야 함)
        planDTO.setUserId(1L);
        planService.insert(planDTO);

        List<PlanDTO> list = planService.list(); // 일정 목록을 가져옴
        model.addAttribute("list", list); // 목록을 모델에 추가

        return "redirect:/plan/list"; // 일정 생성 후 일정 목록으로 뷰 전환
    }


    // 일정 수정
    @GetMapping( "/update")
    public String getUpdate(PlanDTO planDTO, Model model) {
        model.addAttribute("plan", planService.one(planDTO.getId()));
        return "/plan/edit"; // 일정 수정 폼
    }

//    @PostMapping("update")
//    public String update(PlanDTO planDTO) {
//        planService.update(planDTO);
//        return "redirect:/plan/list"; // 일정 수정 후 일정 목록으로 리다이렉트
//    }

    @PostMapping("/update")
    public String update(@RequestParam("id") Long id, PlanDTO planDTO, Model model) {
        planService.update(planDTO);

        // 일정 목록을 다시 가져와서 모델에 추가
        List<PlanDTO> list = planService.list();
        model.addAttribute("list", list);

        return "redirect:/plan/one?id=" + id; // 일정 수정 후 해당 일정 상세 보기로 뷰 전환
    }

//    @RequestMapping("delete")
//    public String delete(PlanDTO planDTO) {
//        planService.delete(planDTO.getId());
//        return "redirect:/plan/list";  // 일정 삭제 후 일정 목록으로 리다이렉트
//    }
    
    // 일정 삭제
    @RequestMapping("/delete")
    public String delete(PlanDTO planDTO, Model model) {
        planService.delete(planDTO.getId());

        // 일정 목록을 다시 가져와서 모델에 추가
        List<PlanDTO> list = planService.list();
        model.addAttribute("list", list);

        return "redirect:/plan/list"; // 일정 삭제 후 일정 목록으로 뷰 전환
    }


    // 일정 상세 보기
    @RequestMapping("/one")
    public String one(@RequestParam("id") Long id, Model model) {
        PlanDTO planDTO = planService.one(id);
        model.addAttribute("plan", planDTO);
        return "/plan/one";
    }

    // 일정 목록 보기
    @RequestMapping("/list")
    public String list(Model model) {
        List<PlanDTO> list = planService.list();
        model.addAttribute("list", list);
        return "/plan/list";
    }
}