package com.multi.hontrip.record.controller;

import com.multi.hontrip.record.dto.CommentDTO;
import com.multi.hontrip.record.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
        commentService.createcmt(commentDTO);
        List<CommentDTO> commentList = commentService.selectPostComment(commentDTO.getRecordId());
        Map<String, Object> map = new HashMap<>();
        map.put("commentList", commentList);
        return ResponseEntity.ok(map); // 이 부분이 JSON으로 반환되는 부분
    }
}
