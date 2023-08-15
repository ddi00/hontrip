package com.multi.hontrip.record.service;

import com.multi.hontrip.record.dao.CommentDAO;
import com.multi.hontrip.record.dto.CommentDTO;
import com.multi.hontrip.record.dto.CreateCommentDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentDAO commentDAO;

    public void createcmt(CreateCommentDTO createCommentDTO) {
        commentDAO.createComeent(createCommentDTO);
    }

    public List<CommentDTO> selectPostComment(String id) {
        return commentDAO.commentList(id);
    }
}
