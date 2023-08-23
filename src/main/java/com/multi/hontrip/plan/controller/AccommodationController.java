package com.multi.hontrip.plan.controller;

import com.multi.hontrip.plan.dto.AccommodationDTO;
import com.multi.hontrip.plan.service.AccommodationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

// 카카오맵 api로 받아온 숙박시설 정보 보여주는 컨트롤러
@Controller
@RequestMapping("/plan/accommodation")
public class AccommodationController {

    @Autowired
    AccommodationService accommodationService;

    @RequestMapping("/one") // 숙박시설 1개만 보기
    public void one(Long accommodationId, Model model) {
        AccommodationDTO plan = accommodationService.one(accommodationId);
        model.addAttribute("plan", plan);
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET) // 숙박시설 리스트
    public String showAccommodationList(Model model) {
        List<AccommodationDTO> list = accommodationService.list();
        model.addAttribute("list", list);
        return "/plan/accommodation/list";
    }

    @RequestMapping(value = "/filter_list", method = RequestMethod.POST) // 숙박시설 필터
    public String filterList(
            @RequestParam(name = "addressName", required = false) String addressName,
            @RequestParam(name = "placeName", required = false) String placeName,
            @RequestParam(name = "categoryName", required = false) String categoryName,
            @RequestParam(name = "filterType", required = false) String filterType, // 필터 타입 추가
            Model model
    ) {
        List<AccommodationDTO> list;

/*if (placeName != null && addressName != null && categoryName != null) {
    // 주소와 카테고리로 동시에 필터링
    list = accommodationService.filterByCategoryAndPlaceNameAndAddress(placeName, addressName, categoryName);
} else*/ if ("address_place".equals(filterType) && addressName != null && placeName != null) {
            // 주소와 이름으로 동시에 필터링
            list = accommodationService.filterByAddressAndPlaceName(addressName, placeName);
        } else if (addressName != null && categoryName != null) {
            // 주소와 카테고리로 동시에 필터링
            list = accommodationService.filterByAddressAndCategoryName(addressName, categoryName);
        } /*else if (placeName != null && categoryName != null) {
            // 이름과 카테고리로 동시에 필터링
            list = accommodationService.filterByPlaceNameAndCategoryName(placeName, categoryName);
        }*/else if ("address".equals(filterType) && addressName != null) {
            // 주소로 필터링
            list = accommodationService.filterByAddress(addressName);
        } else if ("place_name".equals(filterType) && placeName != null) {
            // 이름으로 필터링
            list = accommodationService.filterByPlaceName(placeName);
        } else if (categoryName != null) {
            // 숙박시설 카테고리 필터 (호텔|펜션|콘도,리조트|야영,캠핑장)
            list = accommodationService.filterByCategory(categoryName);
        } else {
            list = accommodationService.list();
        }

        model.addAttribute("list", list);
        return "/plan/accommodation/filter_list";
    }

}