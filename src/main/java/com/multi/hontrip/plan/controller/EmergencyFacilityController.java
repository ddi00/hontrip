package com.multi.hontrip.plan.controller;

import com.multi.hontrip.plan.dto.EmergencyFacilityDTO;
import com.multi.hontrip.plan.service.EmergencyFacilityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/plan")
public class EmergencyFacilityController {
    @Autowired
    EmergencyFacilityService emergencyFacilityService;

    @RequestMapping("/emergency_facility_one") // 일정 하나만 보기
    public void one(Long EmergencyFacilityId, Model model) {
        EmergencyFacilityDTO plan = emergencyFacilityService.one(EmergencyFacilityId);
        model.addAttribute("plan", plan);
    }

    @RequestMapping("/emergency_facility_list") // insert한 일정 리스트
    public void list(Model model) {
        List<EmergencyFacilityDTO> list = emergencyFacilityService.list();
        model.addAttribute("list", list);
    }

}
