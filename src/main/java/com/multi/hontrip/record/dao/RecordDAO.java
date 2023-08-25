package com.multi.hontrip.record.dao;

import com.multi.hontrip.record.dto.CreatePostDTO;
import com.multi.hontrip.record.dto.PostImgDTO;
import com.multi.hontrip.record.dto.LocationDTO;
import com.multi.hontrip.record.dto.PostInfoDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

    public List<PostInfoDTO> getMyList(Long userId){ //내 게시물 전체 리스트 가져오기
        return sqlSessionTemplate.selectList("record.mylist", userId);
    }

    public List<PostInfoDTO> getListMyLocation(Long locationId, Long userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("locationId", locationId);
        params.put("userId", userId);
        return sqlSessionTemplate.selectList("record.listmylocation", params);
    }


    public List<PostInfoDTO> getListMyLocation3(Long locationId, int userId ) { // 내 게시물 검색한 지역 리스트 가져오기
        Map<String, Object> params = new HashMap<>();
        params.put("locationId", locationId);
        params.put("userId", userId);
        return sqlSessionTemplate.selectList("record.listmylocation3", params);
    }

    public List<PostInfoDTO> getFeedList(int isVisible){ //공유피드 전체 리스트 가져오기
        return sqlSessionTemplate.selectList("record.feedlist", isVisible);
    }

    public List<LocationDTO> getMyMap(Long userId){ //공유피드 전체 리스트 가져오기
        return sqlSessionTemplate.selectList("record.mymap", userId);
    }
}
