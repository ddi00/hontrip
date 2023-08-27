package com.multi.hontrip.record.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.record.dto.*;
import com.multi.hontrip.record.service.CommentService;
import com.multi.hontrip.record.service.LocationService;
import com.multi.hontrip.record.service.RecordService;
import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("record")
@RequiredArgsConstructor
@PropertySource("classpath:properties/record/appkey.properties")
public class RecordContorller {
    private final RecordService recordService;
    private final CommentService commentService;
    private final LocationService locationService;

    @Value("${map.appkey}")
    private String MAP_KEY ; //카카오 인증 ID

    @GetMapping("createpost")// 게시물 작성폼에 위치 정보 가져오기
    @RequiredSessionCheck
    public String uploadPostView(Model model, HttpSession session) {
        List<LocationDTO> locationList = locationService.locationList();
        model.addAttribute("locationList", locationList);
        return "/record/createpost";
    }

    @PostMapping("createpost") // 게시물 작성
    public String uploadPost(HttpServletRequest request,
                             @RequestParam("file") MultipartFile file,
                             @RequestParam("multifiles")  MultipartFile[] multifiles,
                             CreatePostDTO createPostDTO) {
        List<String> multifilesUrl = recordService.setMultifiles(multifiles); //이미지 주소

        long postId = recordService.upLoadPost(file, createPostDTO); //id추출
        recordService.imgUrlsInsert(multifilesUrl, postId);
        return "redirect:/record/postinfo?id=" + postId;
    }

    @GetMapping("postinfo") // 게시물 상세 페이지 / 댓글 / 좋아요
    public String postInfo(@RequestParam("id") long id, Model model) {
        PostInfoDTO postInfoDTO = recordService.selectPostInfo(id); //게시물 정보
        List<PostImgDTO> postImgList = recordService.selectPostImg(id); //게시물 이미지
        List<CommentDTO> commentList = commentService.selectPostComment(id); //게시물 댓글
        List<CommentDTO> reCommentList = commentService.reCommentList(commentList); //대댓글
        model.addAttribute("postInfoDTO", postInfoDTO);
        model.addAttribute("commentList", commentList);
        model.addAttribute("postImgList", postImgList);
        model.addAttribute("reCommentList", reCommentList);
        return "/record/postinfo";
    }

    @GetMapping("updatepost") // 게시물 수정 페이지 + 수정 정보
    @RequiredSessionCheck
    public String updatePostInfoView(@RequestParam("id") long id, Model model, HttpSession httpSession) {
        PostInfoDTO postInfoDTO = recordService.selectPostInfo(id);
        List<PostImgDTO> postImgList = recordService.selectPostImg(id); //게시물 이미지
        model.addAttribute("postInfoDTO", postInfoDTO);
        model.addAttribute("postImgList", postImgList);
        return "/record/updatepost";
    }

    @PostMapping("updatepost") // 게시물 수정 적용
    public String updatePostInfo(@RequestParam("file") MultipartFile file,
                                 CreatePostDTO createPostDTO) {
        long postId = recordService.updatePostInfo(file, createPostDTO);
        return "redirect:/record/postinfo?id=" + postId; // 수정후 수정된 게시물 이동
    }

    @GetMapping("deletepost") // 게시물 삭제
    @RequiredSessionCheck
    public String deletePost(@RequestParam long id, HttpSession httpSession) {
        recordService.deletePostInfo(id);
        return "redirect:/record/mylist"; // 삭제후 내 피드로 이동
    }

    @GetMapping("mylist") // 내 게시물 전체 가져오기
    public String getMyList(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        List<PostInfoDTO> getMyList = recordService.getMyList(userId);
        List<LocationDTO> getMyMap = recordService.getMyMap(userId); // 지도 정보 가져오기
        List<LocationDTO> locationList = locationService.locationList(); //드롭다운 컨테이너 지역 정보 가져오기
        model.addAttribute("mylist", getMyList);
        model.addAttribute("mymap", getMyMap);
        model.addAttribute("locationList", locationList);
        model.addAttribute("appkey",MAP_KEY);
        System.out.println("mylist getMyList"+ getMyList);
        System.out.println("mylist getMyMap"+ getMyMap);
        return "/record/mylist"; // 기존의 뷰 이름 반환
    }


    @GetMapping("list_mylocation_click") //  마커클릭시 내 게시물 해당지역 리스트 가져오기
    public void getListMyLocationClick(@RequestParam("locationId") Long locationId, Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        List<PostInfoDTO> getListMyLocationClick = recordService.getListMyLocationClick(locationId, userId);
        List<LocationDTO> getMyMap = recordService.getMyMap(userId);
        List<LocationDTO> locationList = locationService.locationList(); //드롭다운 컨테이너 지역 정보 가져오기
        model.addAttribute("mylist", getListMyLocationClick); // mylist 모델에 데이터 추가
        model.addAttribute("mymap", getMyMap);
        model.addAttribute("locationList", locationList);
        System.out.println("click getListMyLocationClick"+ getListMyLocationClick);
        System.out.println("click getMyMap"+ getMyMap);
    }


    @GetMapping("list_mylocation_dropdown") // 검색어입력시 내 게시물 해당지역 리스트 가져오기
    public void getListMyLocationDrowDown(@RequestParam("locationId") Long locationId, Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        List<PostInfoDTO> getListMyLocationDrowDown = recordService.getListMyLocationDrowDown(locationId, userId);
        List<LocationDTO> getMyMap = recordService.getMyMap(userId);
        List<LocationDTO> locationList = locationService.locationList(); //드롭다운 컨테이너 지역 정보 가져오기
        model.addAttribute("mylist", getListMyLocationDrowDown); // mylist 모델에 데이터 추가
        model.addAttribute("mymap", getMyMap);
        model.addAttribute("locationList", locationList);
        System.out.println("dropdown getListMyLocationDrowDown"+ getListMyLocationDrowDown);
        System.out.println("dropdown getMyMap"+ getMyMap);
    }

    @GetMapping("feedlist") // 공유피드 리스트 가져오기
    public String getFeedList(@RequestParam("isVisible") int isVisible, Model model) {
        List<PostInfoDTO> feedlist = recordService.getFeedList(isVisible);
        model.addAttribute("feedlist", feedlist);
        return "/record/feedlist"; // feedlist.jsp 파일로 반환
    }

}

