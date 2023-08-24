package com.multi.hontrip.plan.controller;

import com.multi.hontrip.plan.service.PlanDayService;
import com.multi.hontrip.plan.service.PlanService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/plan/day")
public class PlanDayController {

    private final PlanDayService planDayService;
    private final PlanService planService;
    @Autowired
    public PlanDayController(PlanDayService planDayService, PlanService planService){
        this.planDayService = planDayService;
        this.planService = planService;
    }

}