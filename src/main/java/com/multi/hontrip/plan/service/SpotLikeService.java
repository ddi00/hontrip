package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.SpotLikeDTO;

import java.util.List;


public interface SpotLikeService {

    // 여행지 즐겨찾기 추가
    void addSpotLike(SpotLikeDTO spotLikeDTO);

    // 여행지 즐겨찾기 해제
    void removeSpotLike(SpotLikeDTO spotLikeDTO);

    // 여행지 즐겨찾기 수 카운트
    int countSpotLike(String spotContentId);

    // 사용자가 즐겨찾기 한 여행지 조회
    List<SpotLikeDTO> listUserLikedSpot(long userId);

    // 사용자가 즐겨찾기 한 여행지 id만 반환
    List<String> listUserLikedSpotId(long userId);

    // 여행지 상세 조회 시 사용자 즐겨찾기 여부 확인
    int checkUserLiked(long userId, String spotContentId);
}
