package com.multi.hontrip.plan.controller;

import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.dto.SpotSearchDTO;
import com.multi.hontrip.plan.parser.SpotParser;
import com.multi.hontrip.plan.service.SpotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.List;
@Controller
@RequestMapping("plan/spot")
public class SpotController {

    private final SpotService spotService;
    @Autowired
    public SpotController(SpotService spotService){
        this.spotService = spotService;
    }

    // 여행지 검색
    @GetMapping("search_form")
    public String showSpotSearchForm(@ModelAttribute("SpotSearchDTO")SpotSearchDTO spotSearchDTO){
        return "plan/spot/search_form"; // 여행지 검색 폼 반환
    }

    // 여행지 검색 목록 - 지역명으로 검색 (키워드 검색 구현 예정)
    @PostMapping("search")
    public String SearchSpot(@ModelAttribute("SpotSearchDTO") SpotSearchDTO spotSearchDTO, Model model)
            throws ParserConfigurationException, SAXException, IOException {
        spotService.parseData(spotSearchDTO);
        model.addAttribute("areaName", spotSearchDTO.getAreaName());
        // DB에서 조건에 맞는 데이터 select
        model.addAttribute("list", spotService.list(spotSearchDTO));

        return "plan/spot/search_list"; // 조건에 맞는 여행지 검색 목록 반환
    }
}
