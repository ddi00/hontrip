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
    @GetMapping("create_comment")
    public Map<String, Object> createComment(CommentDTO commentDTO) {
        commentService.createCmt(commentDTO);
        List<CommentDTO> commentList = commentService.selectPostComment(commentDTO.getRecordId());
        List<CommentDTO> reCommentList = commentService.reCommentList(commentList);

        Map<String, Object> map = new HashMap<>(); // map에 댓글리스트와 대댓글리스트 추가해서 return
        map.put("commentList", commentList);
        map.put("reCommentList", reCommentList);
        return map;
    }

    @ResponseBody
    @GetMapping("delete_comment")
    public Map<String, Object> deleteComment(long cmtId, long recordId) {
        commentService.deleteCmt(cmtId);
        List<CommentDTO> commentList = commentService.selectPostComment(recordId);
        List<CommentDTO> reCommentList = commentService.reCommentList(commentList);

        Map<String, Object> map = new HashMap<>();
        map.put("commentList", commentList);
        map.put("reCommentList", reCommentList);
        return map;
    }

    @ResponseBody
    @GetMapping("update_comment")
    public Map<String, Object> updateComment(CommentDTO commentDTO,
                                             @RequestParam("recordId") long recordId) {
        commentService.updateCmt(commentDTO);
        List<CommentDTO> commentList = commentService.selectPostComment(recordId);
        List<CommentDTO> reCommentList = commentService.reCommentList(commentList);

        Map<String, Object> map = new HashMap<>();
        map.put("commentList", commentList);
        map.put("reCommentList", reCommentList);
        return map;
    }

    @ResponseBody
    @GetMapping("create_recomment")
    public Map<String, Object> createReComment(CommentDTO commentDTO) {
        commentService.createReCmt(commentDTO);
        List<CommentDTO> commentList = commentService.selectPostComment(commentDTO.getRecordId());
        List<CommentDTO> reCommentList = commentService.reCommentList(commentList);

        Map<String, Object> map = new HashMap<>();
        map.put("commentList", commentList);
        map.put("reCommentList", reCommentList);
        return map;
    }
}
