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

    @RequestMapping("/plan_form") // 여행일정 insert 폼을 보여줌
    public String showPlanForm(@ModelAttribute("planDTO") PlanDTO planDTO) {
        return "plan/plan_form"; // "resources/templates/plan/plan_form.html" 템플릿 파일을 사용
    }

    @RequestMapping(value = "/insert_plan", method = RequestMethod.POST) // plan_form에서 작성한 내용 insert
    public String insert(@ModelAttribute("planDTO") PlanDTO planDTO) {
        // 사용자 ID 설정 (실제로는 세션 등에서 가져와야 함)
        planDTO.setUserId(1L);

        // 데이터베이스에 저장
        planService.insert(planDTO);

        // 리다이렉션하여 일정 목록 페이지로 이동
        return "redirect:/plan/plan_list";
    }


@RequestMapping(value= "/plan_update", method = RequestMethod.GET) // plan_edit에서 내용 수정
public String getUpdate(PlanDTO plan, Model model) {
    model.addAttribute("plan", planService.one(plan.getId()));
    return "plan/plan_edit";
}

    @RequestMapping(value= "/plan_update", method = RequestMethod.POST) // 일정 업데이트
    public String update(PlanDTO plan) {
        planService.update(plan);
        System.out.println("Plan updated successfully!");
        return "redirect:/plan/plan_list";
    }

    @RequestMapping("/plan_delete") // 일정 삭제
    public String delete(PlanDTO plan) {
        planService.delete(plan.getId());
        System.out.println("Plan deleted successfully!");
        return "redirect:/plan/plan_list";
    }

    @RequestMapping("/plan_one") // 일정 하나만 보기
    public void one(Long id, Model model) {
        PlanDTO plan = planService.one(id);
        model.addAttribute("plan", plan);
    }

    @RequestMapping("/plan_list") // insert한 일정 리스트
    public void list(Model model) {
        List<PlanDTO> list = planService.list();
        model.addAttribute("list", list);
    }
}
