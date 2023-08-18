package com.multi.hontrip.record.controller;

import com.multi.hontrip.record.dto.CommentDTO;
import com.multi.hontrip.record.dto.CreatePostDTO;
import com.multi.hontrip.record.dto.LocationDTO;
import com.multi.hontrip.record.dto.PostInfoDTO;
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
                             CreatePostDTO createPostDTO) {
        String uploadPath // file 저장 위치
                = request.getSession().getServletContext().getRealPath("resources/img/recordImg");
        long postId = recordService.upLoadPost(uploadPath, file, createPostDTO);
        return "redirect:/record/postinfo?id=" + postId;
    }

    @GetMapping("postinfo") // 게시물 상세 페이지
    public String postInfo(@RequestParam("id") long id, Model model) {
        PostInfoDTO postInfoDTO = recordService.selectPostInfo(id);
        List<CommentDTO> commentList = commentService.selectPostComment(id);
        model.addAttribute("postInfoDTO", postInfoDTO);
        model.addAttribute("commentList", commentList);
        return "/record/postinfo";
    }

    @GetMapping("updatepost") // 게시물 수정 페이지
    public void updatePostInfoView(@RequestParam("id") long id, Model model) {
        PostInfoDTO postInfoDTO = recordService.selectPostInfo(id);
        model.addAttribute("postInfoDTO", postInfoDTO);
    }

    @PostMapping("updatepost") // 게시물 수정 페이지
    public String updatePostInfo(HttpServletRequest request,
                                 @RequestParam("file") MultipartFile file,
                                 CreatePostDTO createPostDTO) {
        String uploadPath // file 저장 위치
                = request.getSession().getServletContext().getRealPath("resources/img/recordImg");
        long postId = recordService.updatePostInfo(uploadPath, file, createPostDTO); // postId값 반환
        return "redirect:/record/postinfo?id=" + postId;
    }

    @GetMapping("deletepost")
    public String deletePost(@RequestParam long id) {
        recordService.deletePostInfo(id);
        return "redirect:/record/createpost";
    }
}

