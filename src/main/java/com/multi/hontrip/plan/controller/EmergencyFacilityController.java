package com.multi.hontrip.plan.controller;

import com.multi.hontrip.plan.dto.EmergencyFacilityDTO;
import com.multi.hontrip.plan.service.EmergencyFacilityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

// 카카오맵 api에서 받아온 응급시설 정보 보여주는 컨트롤러
@Controller
@RequestMapping("/plan")
public class EmergencyFacilityController {
    @Autowired
    EmergencyFacilityService emergencyFacilityService;

    @RequestMapping("/emergency_facility_one") // 응급시설 1개만 보기
    public void one(Long EmergencyFacilityId, Model model) {
        EmergencyFacilityDTO plan = emergencyFacilityService.one(EmergencyFacilityId);
        model.addAttribute("plan", plan);
    }

    @RequestMapping(value = "/emergency_facility_list", method = RequestMethod.GET) // 응급시설 리스트
    public String showEmergencyFacilityList(Model model) {
        List<EmergencyFacilityDTO> list = emergencyFacilityService.list();
        model.addAttribute("list", list);
        return "plan/emergency_facility_list";
    }

    @RequestMapping(value = "/emergency_facility_filter_list", method = RequestMethod.POST) // 응급시설 필터
    public String filterList(@RequestParam(name = "categoryGroupName", required = false) String categoryGroupName,
                             @RequestParam(name = "addressName", required = false) String addressName,
                             Model model) {
        List<EmergencyFacilityDTO> list;
        if (categoryGroupName != null && addressName != null) {
            // 주소와 카테고리 모두 필터링
            list = emergencyFacilityService.filterByCategoryAndAddress(categoryGroupName, addressName);
        } else if (categoryGroupName != null) {
            // 카테고리만 필터링
            list = emergencyFacilityService.filterByCategory(categoryGroupName);
        } else if (addressName != null) {
            // 주소만 필터링
            list = emergencyFacilityService.filterByAddress(addressName);
        } else {
            // 필터 없음
            list = emergencyFacilityService.list();
        }

        model.addAttribute("list", list);
        return "plan/emergency_facility_filter_list";
    }

}
