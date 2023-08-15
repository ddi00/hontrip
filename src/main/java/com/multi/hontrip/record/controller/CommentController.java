package com.multi.hontrip.record.controller;

import com.multi.hontrip.record.dto.CreateCommentDTO;
import com.multi.hontrip.record.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("record")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    @GetMapping("post_comment")
    public void createComment(CreateCommentDTO createCommentDTO, Model model) {
        commentService.createcmt(createCommentDTO);
        model.addAttribute("createCommentDTO", createCommentDTO);
    }
}
