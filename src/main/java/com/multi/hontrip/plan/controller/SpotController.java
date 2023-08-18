package com.multi.hontrip.plan.controller;

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
    @GetMapping("/search_form")
    public String showSpotSearchForm(@ModelAttribute("SpotSearchDTO")SpotSearchDTO spotSearchDTO){
        return "/plan/spot/search_form"; // 여행지 검색 폼 반환
    }

    // 여행지 검색 목록 - 지역명으로 검색
    @PostMapping("/search-area")
    public String searchSpotWithAreaName(@ModelAttribute("SpotSearchDTO") SpotSearchDTO spotSearchDTO, Model model)
            throws ParserConfigurationException, SAXException, IOException {
        // api 호출하여 지역명으로 여행지 조회
        spotService.parseDataWithAreaName(spotSearchDTO);

        model.addAttribute("keyword", spotSearchDTO.getAreaName());
        // DB에서 조건에 맞는 데이터 select
        model.addAttribute("list", spotService.listWithAreaName(spotSearchDTO));

        return "/plan/spot/search_list"; // 조건에 맞는 여행지 검색 목록 반환
    }

    // 여행지 검색 목록 - 키워드로 검색
    @PostMapping("/search-keyword")
    public String searchSpotWithKeyword(@ModelAttribute("SpotSearchDTO") SpotSearchDTO spotSearchDTO, Model model)
            throws ParserConfigurationException, SAXException, IOException {
        // api 호출하여 키워드로 여행지 조회
        spotService.parseDataWithKeyword(spotSearchDTO);

        model.addAttribute("keyword", spotSearchDTO.getTitle());
        // DB에서 조건에 맞는 데이터 select
        model.addAttribute("list", spotService.listWithKeyword(spotSearchDTO));

        return "/plan/spot/search_list"; // 조건에 맞는 여행지 검색 목록 반환
    }

    @GetMapping ("/one")
    public String one(@RequestParam("contentId") String contentId, Model model) throws IOException, ParserConfigurationException, SAXException {
        SpotDTO spotDTO = spotService.one(contentId);
        SpotDTO spot = spotService.updateDetails(spotDTO);
        model.addAttribute("spot", spot);
        return "/plan/spot/one";
    }

}
