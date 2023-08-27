package com.multi.hontrip.record.dao;

import com.multi.hontrip.record.dto.PostLikeDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class PostLikeDAO {

    private final SqlSessionTemplate sqlSessionTemplate;

    public void insertLike(PostLikeDTO postLikeDTO) {
        sqlSessionTemplate.insert("record.insertLike", postLikeDTO);
    }

    public PostLikeDTO selectLike(PostLikeDTO postLikeDTO) {
        return sqlSessionTemplate.selectOne("record.selectLike", postLikeDTO);
    }
}
