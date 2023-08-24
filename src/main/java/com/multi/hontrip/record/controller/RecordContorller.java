package com.multi.hontrip.record.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.record.dto.*;
import com.multi.hontrip.record.service.CommentService;
import com.multi.hontrip.record.service.LocationService;
import com.multi.hontrip.record.service.RecordService;
import lombok.RequiredArgsConstructor;
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
public class RecordContorller {

    private final RecordService recordService;
    private final CommentService commentService;
    private final LocationService locationService;

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
    public String updatePostInfoView(@RequestParam("id") long id, Model model) {
        PostInfoDTO postInfoDTO = recordService.selectPostInfo(id);
        model.addAttribute("postInfoDTO", postInfoDTO);
        return "/record/updatepost";
    }

    @PostMapping("updatepost") // 게시물 수정 적용
    public String updatePostInfo(@RequestParam("file") MultipartFile file,
                                 CreatePostDTO createPostDTO) {
        long postId = recordService.updatePostInfo(file, createPostDTO);
        return "redirect:/record/postinfo?id=" + postId; // 수정후 수정된 게시물 이동
    }

    @GetMapping("deletepost") // 게시물 삭제
    public String deletePost(@RequestParam long id) {
        recordService.deletePostInfo(id);
        return "redirect:/record/mylist"; // 삭제후 내 피드로 이동
    }

    @GetMapping("mylist") // 내 게시물 전체 가져오기
    public String getMyList(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        System.out.println("User ID from Session: " + userId);

        List<CreatePostDTO> getMyList = recordService.getMyList(userId); //dto는 long, db는 int라 형변환 필요
        List<LocationDTO> getMyMap = recordService.getMyMap(userId); // 지도 정보 가져오기
        model.addAttribute("mylist", getMyList);
        model.addAttribute("mymap", getMyMap);
        return "/record/mylist"; // 기존의 뷰 이름 반환
    }


    @GetMapping("list-mylocation") //  마커클릭시 내 게시물 해당지역 리스트 가져오기
    public void getListMyLocation(@RequestParam("locationId") Long locationId, Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        System.out.println("User ID from Session: " + userId); //세션 확인 코드

        List<CreatePostDTO> getListMyLocation = recordService.getListMyLocation(locationId, userId.intValue());
        List<LocationDTO> getMyMap = recordService.getMyMap(userId);
        model.addAttribute("mylist", getListMyLocation); // mylist 모델에 데이터 추가
        model.addAttribute("mymap", getMyMap);
    }

    @GetMapping("list-mylocation2") // 검색어입력시 내 게시물 해당지역 리스트 가져오기
    public void getListMyLocation2(@RequestParam("city") String city, Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        //System.out.println("User ID from Session: " + userId); 세션 확인 코드

        List<CreatePostDTO> getListMyLocation2 = recordService.getListMyLocation2(city, userId.intValue());
        List<LocationDTO> getMyMap = recordService.getMyMap(userId);
        model.addAttribute("mylist", getListMyLocation2); // mylist 모델에 데이터 추가
        model.addAttribute("mymap", getMyMap);
    }

    @GetMapping("feedlist") // 공유피드 리스트 가져오기
    public String getFeedList(@RequestParam("isVisible") int isVisible, Model model) {
        List<PostInfoDTO> feedlist = recordService.getFeedList(isVisible);
        model.addAttribute("feedlist", feedlist);
        return "/record/feedlist"; // feedlist.jsp 파일로 반환
    }

}

