package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.SpotLikeDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Repository
@RequiredArgsConstructor
public class SpotLikeDAO {

    private final SqlSessionTemplate my;

    // 여행지 좋아요 추가
    public void insertSpotLike(SpotLikeDTO spotLikeDTO){
        my.insert("spot.insertSpotLike", spotLikeDTO);
    }
    // 여행지 좋아요 해제
    public void deleteSpotLike(SpotLikeDTO spotLikeDTO){
        my.delete("spot.deleteSpotLike", spotLikeDTO);
    }

    // 여행지 좋아요 조회
    public int countSpotLike(String spotContentId) {
        return my.selectOne("spot.countSpotLike", spotContentId);
    }

    // 사용자가 좋아요 한 여행지 조회
    public List<SpotLikeDTO> listUserLikedSpot(long userId){
        return my.selectList("spot.listUserLikedSpot", userId);
    }

    // 사용자가 좋아요 한 여행지 id만 조회
    public List<String> listUserLikedSpotId(long userId){
        return my.selectList("spot.listUserLikedSpotId", userId);
    }

    // 여행지 상세 조회 시 사용자 즐겨찾기 여부 확인
    public int checkUserLiked(SpotLikeDTO spotLikeDTO){
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("userId", spotLikeDTO.getUserId());
        paramMap.put("spotContentId", spotLikeDTO.getSpotContentId());
        return my.selectOne("spot.checkUserLiked", paramMap);
    }
}
