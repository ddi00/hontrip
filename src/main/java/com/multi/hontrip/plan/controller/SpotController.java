package com.multi.hontrip.plan.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.dto.SpotSearchDTO;
import com.multi.hontrip.plan.service.SpotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/plan/spot")
public class SpotController {

    private final SpotService spotService;
    @Autowired
    public SpotController(SpotService spotService){
        this.spotService = spotService;
    }

    // 여행지 검색
    @GetMapping("/search")
    public String showSpotSearchForm(@ModelAttribute("SpotSearchDTO") SpotSearchDTO spotSearchDTO){
        return "/plan/spot/search_form"; // 여행지 검색 폼 반환
    }

    // 여행지 검색 목록
    @PostMapping("/search")
    public String searchSpot(@ModelAttribute("SpotSearchDTO") SpotSearchDTO spotSearchDTO, Model model)
            throws ParserConfigurationException, SAXException, IOException {

        List<SpotDTO> spotList = spotService.searchSpots(spotSearchDTO); // 여행지 검색
        if(spotList.isEmpty()){
            model.addAttribute("message", "검색 결과가 없습니다."); // 검색 데이터 없는 경우 메시지 표시
        } else {
            model.addAttribute("list", spotList);
        }

        model.addAttribute("category", spotSearchDTO.getCategory());
        model.addAttribute("keyword", spotSearchDTO.getKeyword());
        model.addAttribute("numOfSpots", spotService.countSpot(spotSearchDTO.getKeyword()));

        return "/plan/spot/search_list"; // 조건에 맞는 여행지 검색 목록 반환
    }
    
    // 여행지 상세
    @GetMapping ("/detail")
    public String one(@RequestParam("contentId") String contentId, Model model) throws IOException, ParserConfigurationException, SAXException {
        SpotDTO spotDTO = spotService.findSpot(contentId);
        SpotDTO spot = spotService.updateDetails(spotDTO);
        model.addAttribute("spot", spot);
        return "/plan/spot/detail";
    }
}
