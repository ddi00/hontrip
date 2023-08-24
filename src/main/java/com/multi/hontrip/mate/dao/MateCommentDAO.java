package com.multi.hontrip.mate.dao;

import com.multi.hontrip.mate.dto.MateCommentDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MateCommentDAO {
    @Autowired
    SqlSessionTemplate my;

    //게시물 1개당 아래쪽에 붙여넣을 댓글 list가지고 올 예정.
    public List<MateCommentDTO> list(long mateBoardId) {
        return my.selectList("mateBbs.commentList", mateBoardId);
    }

    public int insert(MateCommentDTO mateCommentDTO) {
        return my.insert("mateBbs.commentInsert", mateCommentDTO);
    }

    public void delete(MateCommentDTO mateCommentDTO) {
         my.delete("mateBbs.commentDelete", mateCommentDTO);
    }

    public void edit(MateCommentDTO mateCommentDTO) {
        my.update("mateBbs.commentUpdate", mateCommentDTO);
    }

    public int replyInsert(MateCommentDTO mateCommentDTO) {
        return my.insert("mateBbs.replyInsert", mateCommentDTO);
    }
}
