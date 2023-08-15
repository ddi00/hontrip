package com.multi.hontrip.record.dao;

import com.multi.hontrip.record.dto.CommentDTO;
import com.multi.hontrip.record.dto.CreateCommentDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class CommentDAO {

    private final SqlSessionTemplate sqlSessionTemplate;

    public List<CommentDTO> commentList(String id) {
        return sqlSessionTemplate.selectList("record.commentList", id); //List<ReplyDTO>
    }

    public void createComeent(CreateCommentDTO createCommentDTO) {
        sqlSessionTemplate.insert("record.createComment", createCommentDTO);
    }
}
