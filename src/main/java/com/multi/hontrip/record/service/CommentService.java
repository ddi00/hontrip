package com.multi.hontrip.record.service;

import com.multi.hontrip.record.dao.CommentDAO;
import com.multi.hontrip.record.dto.CommentDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentDAO commentDAO;

    public void createCmt(CommentDTO commentDTO) {
        commentDAO.createComeent(commentDTO);
    }

    public List<CommentDTO> selectPostComment(long id) {
        return commentDAO.commentList(id);
    }

    public void deleteCmt(long id) {
        commentDAO.deleteComment(id);
    }

    public void updateCmt(CommentDTO commentDTO) {
        commentDAO.updateComment(commentDTO);
    }

    public ResponseEntity<Map<String, Object>> commentList(long recordId) {
        List<CommentDTO> commentList = commentDAO.commentList(recordId);
        Map<String, Object> map = new HashMap<>();
        map.put("commentList", commentList);
        return ResponseEntity.ok(map); // 이 부분이 JSON으로 반환되는 부분
    }
}
