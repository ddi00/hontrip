package com.multi.hontrip.plan.controller;

import com.multi.hontrip.plan.dto.PlanDTO;
import com.multi.hontrip.plan.dto.PlanDayDTO;
import com.multi.hontrip.plan.service.PlanDayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;

@Controller
@RequestMapping("/plan")
public class PlanDayController {
    @Autowired
    PlanDayService planDayService;

    @PostMapping("/day/insert")
    public String insertDayDetail(@RequestParam("planId") Long planId,
                                  @RequestParam("dayDate") @DateTimeFormat(pattern = "yyyy-MM-dd") Date dayDate,
                                  @RequestParam("daySummary") String daySummary) {
        planDayService.insert(planId, dayDate, daySummary);
        return "redirect:/plan/one?id=" + planId;
    }

}
