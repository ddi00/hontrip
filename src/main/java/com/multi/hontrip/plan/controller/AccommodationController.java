package com.multi.hontrip.plan.controller;

import com.multi.hontrip.plan.dto.AccommodationDTO;
import com.multi.hontrip.plan.service.AccommodationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/plan")
public class AccommodationController {

    @Autowired
    AccommodationService accommodationService;

    @RequestMapping("/accommodation_one") // 일정 하나만 보기
    public void one(Long accommodationId, Model model) {
        AccommodationDTO plan = accommodationService.one(accommodationId);
        model.addAttribute("plan", plan);
    }

    @RequestMapping("/accommodation_list") // insert한 일정 리스트
    public void list(Model model) {
        List<AccommodationDTO> list = accommodationService.list();
        model.addAttribute("list", list);
    }

}
