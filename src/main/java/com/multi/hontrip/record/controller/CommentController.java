package com.multi.hontrip.record.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.record.dto.CommentDTO;
import com.multi.hontrip.record.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("record")
@RequiredArgsConstructor
public class CommentController {

    private final CommentService commentService;

    @ResponseBody
    @GetMapping("create_comment") // 댓글 작성
    @RequiredSessionCheck
    public Map<String, Object> createComment(CommentDTO commentDTO, HttpSession httpSession) {
        commentService.createCmt(commentDTO);
        List<CommentDTO> commentList = commentService.selectPostComment(commentDTO.getRecordId());
        List<CommentDTO> reCommentList = commentService.reCommentList(commentList); // 답글만 담겨있음

        Map<String, Object> map = new HashMap<>(); // map에 댓글리스트와 대댓글리스트 추가해서 return
        map.put("commentList", commentList);
        map.put("reCommentList", reCommentList);
        return map;
    }

    @ResponseBody
    @GetMapping("delete_comment") // 댓글 삭제
    @RequiredSessionCheck
    public Map<String, Object> deleteComment(long cmtId, long recordId, HttpSession httpSession) {
        commentService.deleteCmt(cmtId);
        List<CommentDTO> commentList = commentService.selectPostComment(recordId);
        List<CommentDTO> reCommentList = commentService.reCommentList(commentList);

        Map<String, Object> map = new HashMap<>();
        map.put("commentList", commentList);
        map.put("reCommentList", reCommentList);
        return map;
    }

    @ResponseBody
    @GetMapping("update_comment") // 댓글 수정
    @RequiredSessionCheck
    public Map<String, Object> updateComment(CommentDTO commentDTO,
                                             @RequestParam("recordId") long recordId,
                                             HttpSession httpSession) {
        commentService.updateCmt(commentDTO);
        List<CommentDTO> commentList = commentService.selectPostComment(recordId);
        List<CommentDTO> reCommentList = commentService.reCommentList(commentList);

        Map<String, Object> map = new HashMap<>();
        map.put("commentList", commentList);
        map.put("reCommentList", reCommentList);
        return map;
    }

    @ResponseBody
    @GetMapping("create_recomment") // 답글 작성
    @RequiredSessionCheck
    public Map<String, Object> createReComment(CommentDTO commentDTO, HttpSession httpSession) {
        commentService.createReCmt(commentDTO);
        List<CommentDTO> commentList = commentService.selectPostComment(commentDTO.getRecordId());
        List<CommentDTO> reCommentList = commentService.reCommentList(commentList);

        Map<String, Object> map = new HashMap<>();
        map.put("commentList", commentList);
        map.put("reCommentList", reCommentList);
        return map;
    }
}
