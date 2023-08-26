package com.multi.hontrip.record.dao;

import com.multi.hontrip.record.dto.CommentDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class CommentDAO {

    private final SqlSessionTemplate sqlSessionTemplate;

    public List<CommentDTO> commentList(long id) {
        return sqlSessionTemplate.selectList("record.commentList", id);
    }

    public void createComeent(CommentDTO commentDTO) {
        sqlSessionTemplate.insert("record.createComment", commentDTO);
    }

    public void createReComment(CommentDTO commentDTO) {
        sqlSessionTemplate.insert("record.insertNewReComment", commentDTO);
    }

    public void deleteComment(long id) {
        sqlSessionTemplate.delete("record.deleteComment", id);
    }

    public void deleteReComment(Long id) {
        sqlSessionTemplate.delete("record.deleteReComment", id);
    }

    public void updateComment(CommentDTO commentDTO) {
        sqlSessionTemplate.update("record.updateComment", commentDTO);
    }
}
