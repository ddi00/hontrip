package com.multi.hontrip.plan.controller;

import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.dto.SpotSearchDTO;
import com.multi.hontrip.plan.service.SpotServiceImpl;
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

    private final SpotServiceImpl spotService;
    @Autowired
    public SpotController(SpotServiceImpl spotService){
        this.spotService = spotService;
    }

    // 여행지 검색
    @GetMapping("/search")
    public String showSpotSearchForm(@ModelAttribute("SpotSearchDTO")SpotSearchDTO spotSearchDTO){
        return "/plan/spot/search_form"; // 여행지 검색 폼 반환
    }

    // 여행지 검색 목록
    @PostMapping("/search")
    public String searchSpot(@ModelAttribute("SpotSearchDTO") SpotSearchDTO spotSearchDTO, Model model)
            throws ParserConfigurationException, SAXException, IOException {

        // 사용자 검색 범주에 따라 키워드 검색 / 지역 검색으로 분기
        if (spotSearchDTO.getCategory().equals("keyword")){
            // api 호출하여 키워드로 여행지 조회
            spotService.parseData(spotSearchDTO);
            // DB에서 조건에 맞는 데이터 select
            List<SpotDTO> spotList = spotService.list(spotSearchDTO);
            // 검색 데이터 없는 경우 메시지 표시
            if(spotList.isEmpty()){
                model.addAttribute("message", "검색 결과가 없습니다.");
            }
            model.addAttribute("list", spotList);

        }else if (spotSearchDTO.getCategory().equals("area")){
            // api 호출하여 지역명으로 여행지 조회
            spotService.parseData(spotSearchDTO);
            // DB에서 조건에 맞는 데이터 select
            List<SpotDTO> spotList = spotService.list(spotSearchDTO);
            // 검색 데이터 없는 경우 메시지 표시
            if(spotList.isEmpty()){
                model.addAttribute("message", "검색 결과가 없습니다.");
            }
            model.addAttribute("list", spotList);
        }
        model.addAttribute("category", spotSearchDTO.getCategory());
        model.addAttribute("keyword", spotSearchDTO.getKeyword());

        return "/plan/spot/search_list"; // 조건에 맞는 여행지 검색 목록 반환
    }
    
    // 여행지 상세
    @GetMapping ("/detail")
    public String one(@RequestParam("contentId") String contentId, Model model) throws IOException, ParserConfigurationException, SAXException {
        SpotDTO spotDTO = spotService.one(contentId);
        SpotDTO spot = spotService.updateDetails(spotDTO);
        model.addAttribute("spot", spot);
        return "/plan/spot/detail";
    }
}
