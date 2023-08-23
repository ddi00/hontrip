package com.multi.hontrip.record.service;

import com.multi.hontrip.record.dao.CommentDAO;
import com.multi.hontrip.record.dto.CommentDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentDAO commentDAO;

    //댓글 작성
    public void createCmt(CommentDTO commentDTO) {
        commentDAO.createComeent(commentDTO);
    }

    //대댓글 작성
    public void createReCmt(CommentDTO commentDTO) {
        commentDAO.createReComment(commentDTO);
    }

    //댓글 삭제
    public void deleteCmt(long id) {
        commentDAO.deleteComment(id);
    }

    //댓글 수정
    public void updateCmt(CommentDTO commentDTO) {
        commentDAO.updateComment(commentDTO);
    }

    //댓글 리스트 가져오기
    public List<CommentDTO> selectPostComment(long id) {
        return commentDAO.commentList(id);
    }

    //대댓글 리스트 가져오기
    public List<CommentDTO> reCommentList(List<CommentDTO> commentList) {
        List<CommentDTO> reCommentList = new ArrayList<>();
        for (CommentDTO commentDTO : commentList) {
            if (commentDTO.getCmtSequence() == 1) { //cmtSequence가 1인것만 가져와라 => 대댓글
                reCommentList.add(commentDTO);
            }
        }
        return reCommentList;
    }
}
