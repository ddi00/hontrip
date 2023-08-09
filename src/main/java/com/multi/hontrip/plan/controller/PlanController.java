package com.multi.hontrip.plan.controller;

import com.multi.hontrip.plan.dto.PlanDTO;
import com.multi.hontrip.plan.service.PlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class PlanController {

    @Autowired
    PlanService planService;

    @RequestMapping("/plan_form")
    public String showPlanForm() {
        return "plan_form";
    }

    @RequestMapping(value = "/insert_plan", method = RequestMethod.POST, consumes = "application/json")
    @ResponseBody
    public String insert(@RequestBody PlanDTO planDTO) {
        planDTO.setUser_id(1L); // 사용자 ID 설정 (실제로는 세션 등에서 가져와야 함)
        planService.insert(planDTO);
        return "Plan inserted successfully!";
    }

    @RequestMapping("plan_update")
    public String update(PlanDTO planDTO, Model model) {
        PlanDTO newPlan = new PlanDTO();
        newPlan.setId(planDTO.getId());
        newPlan.setUser_id(planDTO.getUser_id());
        // 다른 변경 사항도 위와 같이..

        planService.update(newPlan);
        //return "redirect:plan_list.jsp";
        return null;

    }

    @RequestMapping("plan_delete")
    public void delete(Long id, Model model) {
        planService.delete(id);
    }

    @RequestMapping("plan_one")
    public PlanDTO one(Long id) {
        PlanDTO planDTO = planService.one(id);
        return planDTO;
    }

    @RequestMapping("plan_list")
    @ResponseBody
    public void list(Model model) {
        List<PlanDTO> list = planService.list();
        model.addAttribute("list", list);
    }
}