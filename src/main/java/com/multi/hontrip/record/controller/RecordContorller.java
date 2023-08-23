package com.multi.hontrip.record.controller;

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
import java.util.List;

@Controller
@RequestMapping("record")
@RequiredArgsConstructor
public class RecordContorller {

    private final RecordService recordService;
    private final CommentService commentService;
    private final LocationService locationService;

    @GetMapping("createpost")
    public String uploadPostView(Model model) {
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
        System.out.println("이미지 개수 => " + multifilesUrl.size());

        long postId = recordService.upLoadPost(file, createPostDTO); //id추출
        recordService.imgUrlsInsert(multifilesUrl, postId);
        return "redirect:/record/postinfo?id=" + postId;
    }

    @GetMapping("postinfo") // 게시물 상세 페이지
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

    @GetMapping("updatepost") // 게시물 수정 페이지
    public void updatePostInfoView(@RequestParam("id") long id, Model model) {
        PostInfoDTO postInfoDTO = recordService.selectPostInfo(id);
        model.addAttribute("postInfoDTO", postInfoDTO);
    }

    @PostMapping("updatepost") // 게시물 수정 페이지
    public String updatePostInfo(@RequestParam("file") MultipartFile file,
                                 CreatePostDTO createPostDTO) {
        long postId = recordService.updatePostInfo(file, createPostDTO);
        return "redirect:/record/postinfo?id=" + postId;
    }

    @GetMapping("deletepost")
    public String deletePost(@RequestParam long id) {
        recordService.deletePostInfo(id);
        return "redirect:/record/mylist";
    }

    @GetMapping("mylist") // 내 게시물 전체 가져오기
    public String getMyList(Model model) {

        List<CreatePostDTO> getMyList = recordService.getMyList();
        List<LocationDTO> getMyMap = recordService.getMyMap();
        model.addAttribute("mylist", getMyList);
        model.addAttribute("mymap", getMyMap);
        System.out.println(getMyList);
        System.out.println(getMyMap);
        return "/record/mylist"; // 기존의 뷰 이름 반환
    }

    @GetMapping("list-mylocation") // 내 게시물 해당지역 리스트 가져오기
    public void getListMyLocation(@RequestParam("locationId") int locationId, Model model) {
        List<CreatePostDTO> getListMyLocation = recordService.getListMyLocation(locationId);
        List<LocationDTO> getMyMap = recordService.getMyMap();
        model.addAttribute("mylist", getListMyLocation); // mylist 모델에 데이터 추가
        model.addAttribute("mymap", getMyMap);
        System.out.println(getListMyLocation);
        System.out.println(getMyMap);
    }

    @GetMapping("list-mylocation2") // 내 게시물 해당지역 리스트 가져오기
    public void getListMyLocation2(@RequestParam("locationCity") String locationCity, Model model) {
        List<CreatePostDTO> getListMyLocation2 = recordService.getListMyLocation2(locationCity);
        List<LocationDTO> getMyMap = recordService.getMyMap();
        model.addAttribute("mylist", getListMyLocation2); // mylist 모델에 데이터 추가
        model.addAttribute("mymap", getMyMap);
        System.out.println(getListMyLocation2);
        System.out.println(getMyMap);
    }


    @GetMapping("feedlist") // 공유피드 리스트 가져오기
    public String getFeedList(@RequestParam("isVisible") int isVisible, Model model) {
        List<PostInfoDTO> feedlist = recordService.getFeedList(isVisible);
        model.addAttribute("feedlist", feedlist);
        System.out.println(feedlist);
        return "/record/feedlist"; // feedlist.jsp 파일로 반환
    }

}

