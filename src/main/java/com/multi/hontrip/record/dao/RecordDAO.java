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

    public List<PostInfoDTO> getListMyLocationClick(Long locationId, Long userId) {
        Map<String, Object> params = new HashMap<>();
        params.put("locationId", locationId);
        params.put("userId", userId);
        return sqlSessionTemplate.selectList("record.list_mylocation_click", params);
    }

    public List<PostInfoDTO> getListMyLocationDrowDown(Long locationId, Long userId ) {
        Map<String, Object> params = new HashMap<>();
        params.put("locationId", locationId);
        params.put("userId", userId);
        return sqlSessionTemplate.selectList("record.list_mylocation_dropdown", params);
    }

    public List<LocationDTO> getMyMap(Long userId){ //공유피드 전체 리스트 가져오기
        return sqlSessionTemplate.selectList("record.mymap", userId);
    }

    public List<PostInfoDTO> getFeedList(int isVisible){ //공유피드 전체 리스트 가져오기
        return sqlSessionTemplate.selectList("record.feedlist", isVisible);
    }


    public List<PostInfoDTO> getFeedListDropdownAll(String locationIdPattern) {
        return sqlSessionTemplate.selectList("record.feedlist_by_location_pattern_all");
    }


    public List<PostInfoDTO> getFeedListDropdown(String locationIdPattern, String locationIdSpecialId, String locationIdSpecialId2, String locationIdSpecialId3) {
        System.out.println("dao 확인 : " + locationIdPattern + locationIdSpecialId );
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("locationIdPattern", locationIdPattern);
        paramMap.put("locationIdSpecialId", locationIdSpecialId);
        paramMap.put("locationIdSpecialId2", locationIdSpecialId2);
        paramMap.put("locationIdSpecialId3", locationIdSpecialId3);
        return sqlSessionTemplate.selectList("record.feedlist_by_location_pattern", paramMap);
    }

}
