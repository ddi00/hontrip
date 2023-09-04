package com.multi.hontrip.plan.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.dto.SpotLikeDTO;
import com.multi.hontrip.plan.dto.SpotSearchDTO;
import com.multi.hontrip.plan.service.SpotLikeService;
import com.multi.hontrip.plan.service.SpotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.xml.sax.SAXException;

import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/plan/spot")
public class SpotController {

    private final SpotService spotService;
    private final SpotLikeService spotLikeService;

    @Autowired
    public SpotController(SpotService spotService, SpotLikeService spotLikeService) {
        this.spotService = spotService;
        this.spotLikeService = spotLikeService;
    }

    // 여행지 검색
    @GetMapping("/search")
    public String showSpotSearchForm(@ModelAttribute("SpotSearchDTO") SpotSearchDTO spotSearchDTO) {
        return "/plan/spot/search_form"; // 여행지 검색 폼 반환
    }

    // 여행지 검색 목록
    @PostMapping("/search")
    @RequiredSessionCheck
    public String searchSpot(@ModelAttribute("SpotSearchDTO") SpotSearchDTO spotSearchDTO, HttpSession session, Model model)
            throws ParserConfigurationException, SAXException, IOException {

        List<SpotDTO> spotList = spotService.searchSpots(spotSearchDTO); // 여행지 검색
        if (spotList.isEmpty()) {
            model.addAttribute("message", "검색 결과가 없습니다."); // 검색 데이터 없는 경우 메시지 표시
        } else {
            model.addAttribute("list", spotList);
        }

        long userId = (long) session.getAttribute("id");
        List<String> userLikedSpotIdList = spotLikeService.listUserLikedSpotId(userId); // 사용자가 즐겨찾기 한 여행지 id 목록
        String[] userLikedSpotIdsArray = userLikedSpotIdList.toArray(new String[0]);
        String userLikedSpotIds = String.join(":", userLikedSpotIdsArray);

        model.addAttribute("userLikedSpotIds", userLikedSpotIds);
        model.addAttribute("category", spotSearchDTO.getCategory());
        model.addAttribute("keyword", spotSearchDTO.getKeyword());
        model.addAttribute("numOfSpots", spotService.countSpot(spotSearchDTO.getKeyword()));

        return "/plan/spot/search_list"; // 조건에 맞는 여행지 검색 목록 반환
    }

    // 여행지 상세
    @GetMapping("/detail")
    public String showSpotDetail(@RequestParam("category") String category,
                                 @RequestParam("keyword") String keyword,
                                 @RequestParam("contentId") String contentId,
                                 HttpSession session, Model model) throws IOException, ParserConfigurationException, SAXException {
        SpotDTO spotDTO = spotService.findSpot(contentId);
        // 해당 여행지 세부 정보 존재 여부 조회
        int status = spotService.checkSpotDetails(contentId);
        SpotDTO spot = new SpotDTO();
        // 있다면 db select, 없다면 api 호출하여 db insert
        if(status == 1){
            spot = spotService.findSpot(contentId);
        } else if (status == 0){
            spot = spotService.updateDetails(spotDTO);
        }

        // 해당 여행지의 사용자 즐겨찾기 여부 확인
        long userId = (long) session.getAttribute("id");
        int isLiked = spotLikeService.checkUserLiked(userId, contentId);
        
        // 해당 여행지의 즐겨찾기 수 
        int spotLikeCount = spotLikeService.countSpotLike(contentId);

        model.addAttribute("isLiked", isLiked);
        model.addAttribute("spot", spot);
        model.addAttribute("category", category);
        model.addAttribute("keyword", keyword);
        model.addAttribute("likeCount", spotLikeCount);
        return "/plan/spot/detail";
    }

    // 여행지 좋아요 추가
    @GetMapping("/add-spot-like")
    @ResponseBody
    @RequiredSessionCheck
    public ResponseEntity<Integer> addSpotLike(@ModelAttribute SpotLikeDTO spotLikeDTO, HttpSession session) {
        spotLikeService.addSpotLike(spotLikeDTO);
        int spotLikeCount = spotLikeService.countSpotLike(spotLikeDTO.getSpotContentId());
        return ResponseEntity.ok(spotLikeCount);
    }

    // 여행지 좋아요 해제
    @GetMapping("/delete-spot-like")
    @ResponseBody
    @RequiredSessionCheck
    public ResponseEntity<Integer> removeLikedSpot(@ModelAttribute SpotLikeDTO spotLikeDTO, HttpSession session) {
        spotLikeService.removeSpotLike(spotLikeDTO);
        int spotLikeCount = spotLikeService.countSpotLike(spotLikeDTO.getSpotContentId());
        return ResponseEntity.ok(spotLikeCount);
    }
}
