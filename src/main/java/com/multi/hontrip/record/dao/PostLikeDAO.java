package com.multi.hontrip.record.dao;

import com.multi.hontrip.record.dto.PostLikeDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class PostLikeDAO {

    private final SqlSessionTemplate sqlSessionTemplate;

    public void insertLike(PostLikeDTO postLikeDTO) {
        sqlSessionTemplate.insert("record.insertLike", postLikeDTO);
    }

    public void deleteLike(PostLikeDTO postLikeDTO) {
        sqlSessionTemplate.delete("record.deleteLike", postLikeDTO);
    }

    // 유저 정보 담은 게시물 좋아요 리스트
    public List<PostLikeDTO> selectLike(long recordId) {
        return sqlSessionTemplate.selectList("record.selectLikeList", recordId);
    }
}
