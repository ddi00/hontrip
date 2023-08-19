package com.multi.hontrip.record.controller;

import com.multi.hontrip.record.dto.CommentDTO;
import com.multi.hontrip.record.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("record")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    @ResponseBody
    @GetMapping("post_comment")
    public ResponseEntity <Map<String, Object>> createComment(CommentDTO commentDTO) {
        commentService.createCmt(commentDTO);
        return commentService.commentList(commentDTO.getRecordId());
    }

    @ResponseBody
    @GetMapping("delete_comment")
    public ResponseEntity <Map<String, Object>> deleteComment(long cmtId, long recordId) {
        commentService.deleteCmt(cmtId);
        return commentService.commentList(recordId);
    }

    public void updateComment(CommentDTO commentDTO) {
        commentService.updateCmt(commentDTO);
    }//
}
