package com.multi.hontrip.record.dao;

import com.multi.hontrip.record.dto.*;
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

    public void incrementPostViews(long id) { // 게시물 id 받아옴
        sqlSessionTemplate.update("record.incrementPostViews", id);
    }


    public void insertPost(CreatePostDTO createPostDTO) {
        sqlSessionTemplate.insert("record.createPost", createPostDTO);
    }

    public void insertImg(PostImgDTO postImgDTO) {
        sqlSessionTemplate.insert("record.createPostImg", postImgDTO);
    }

    public List<PostImgDTO> selectImg(long recordId) { // 게시물 이미지 리스트
        return sqlSessionTemplate.selectList("record.postImgList", recordId);
    }

    public PostInfoDTO selectPost(long id) { // 게시물 상세 페이지
        return sqlSessionTemplate.selectOne("record.selectPostInfo", id);
    }

    public void updatePost(CreatePostDTO createPostDTO) { // 게시물 수정
        sqlSessionTemplate.update("record.updatePostInfo", createPostDTO);
    }

    public void deletePost(long id) { // 게시물 삭제
        sqlSessionTemplate.delete("record.deletePost", id);
    }

    // 좋아요순 게시물 10개
    public List<PostInfoDTO> likeTopTen() {
        return sqlSessionTemplate.selectList("likeTop10");
    }

    // 디폴트 마이 리스트
    public List<PostInfoDTO> getMyList(Long userId){ //내 게시물 전체 리스트 가져오기
        return sqlSessionTemplate.selectList("record.mylist", userId);
    }

    // 무한 스크롤 리로드 마이 리스트
    public List<PostInfoDTO> getMyListWithScroll(PostScrollDTO postScrollDTO) {
        return sqlSessionTemplate.selectList("record.mylistScroll", postScrollDTO);
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

    public List<PostInfoDTO> getFeedList(){ //공유피드 전체 리스트 가져오기
        return sqlSessionTemplate.selectList("record.feedlist");
    }

    public List<PostInfoDTO> getFeedListWithScroll(PostScrollDTO postScrollDTO) {
        return sqlSessionTemplate.selectList("record.feedlistScroll", postScrollDTO);
    }

    public List<PostInfoDTO> getFeedListLocationButtonsAll(String locationIdPattern) { //공유피드에서 버튼 클릭 시 전국 리스트 가져오기
        return sqlSessionTemplate.selectList("record.feedListLocationButtonsAll");
    }


    public List<PostInfoDTO> getFeedListLocationButtons(String locationIdPattern, String locationIdSpecialId, String locationIdSpecialId2, String locationIdSpecialId3) { //공유피드에서 지역 버튼 클릭 시 리스트 가져오기
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("locationIdPattern", locationIdPattern);
        paramMap.put("locationIdSpecialId", locationIdSpecialId);
        paramMap.put("locationIdSpecialId2", locationIdSpecialId2);
        paramMap.put("locationIdSpecialId3", locationIdSpecialId3);
        return sqlSessionTemplate.selectList("record.feedListLocationButtons", paramMap);
    }

    public List<PostInfoDTO> getFeedListLike(){ //공유피드 좋아요순 리스트 가져오기
        return sqlSessionTemplate.selectList("record.feedlist_like");
    }

}
