package com.multi.hontrip.plan.controller;


import com.multi.hontrip.plan.dto.PlanDTO;
import com.multi.hontrip.plan.service.PlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class PlanController {

    @Autowired
    PlanService planService;

    @RequestMapping("insert.plan")
    @ResponseBody
    public void insert(PlanDTO planDTO, Model model) {
        planService.insert(planDTO);
    }

    @RequestMapping("update.plan")
    @ResponseBody
    public String update(PlanDTO planDTO, Model model) {
            PlanDTO newPlan = new PlanDTO();
            newPlan.setId(planDTO.getId());
            newPlan.setUserId(planDTO.getUserId());
            // 다른 변경 사항도 위와 같이..

            planService.update(newPlan);
            //return "redirect:plan.jsp";
            return null;

    }

    @RequestMapping("delete.plan")
    @ResponseBody
    public void delete(Long id, Model model) {
        planService.delete(id);
    }

    @RequestMapping("one.plan")
    @ResponseBody
    public PlanDTO one(Long id) {
        PlanDTO planDTO = planService.one(id);
        return planDTO;
    }

    @RequestMapping("list.plan")
    @ResponseBody
    public List<PlanDTO> list() {
        List<PlanDTO> list = planService.list();
        return list;
    }
}
