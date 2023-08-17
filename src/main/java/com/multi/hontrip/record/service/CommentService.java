package com.multi.hontrip.record.service;

import com.multi.hontrip.record.dao.CommentDAO;
import com.multi.hontrip.record.dto.CommentDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CommentService {

    private final CommentDAO commentDAO;

    public void createcmt(CommentDTO commentDTO) {
        commentDAO.createComeent(commentDTO);
    }

    public List<CommentDTO> selectPostComment(long id) {
        return commentDAO.commentList(id);
    }
}
