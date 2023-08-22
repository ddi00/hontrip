package com.multi.hontrip.record.dao;

import com.multi.hontrip.record.dto.CreatePostDTO;
import com.multi.hontrip.record.dto.PostImgDTO;
import com.multi.hontrip.record.dto.PostInfoDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class RecordDAO {

    private final SqlSessionTemplate sqlSessionTemplate;

    public void insertPost(CreatePostDTO createPostDTO) {
        sqlSessionTemplate.insert("record.createPost", createPostDTO);
    }

    public void insertImg(PostImgDTO postImgDTO) {
        sqlSessionTemplate.insert("record.createPostImg", postImgDTO);
    }

    public List<PostImgDTO> selectImg(long recordId) {
        return sqlSessionTemplate.selectList("record.postImgList", recordId);
    }

    public PostInfoDTO selectPost(long id) {
        return sqlSessionTemplate.selectOne("record.selectPostInfo", id);
    }

    public void updatePost(CreatePostDTO createPostDTO) {
        sqlSessionTemplate.update("record.updatePostInfo", createPostDTO);
    }

    public void deletePost(long id) {
        sqlSessionTemplate.delete("record.deletePost", id);
    }
}
