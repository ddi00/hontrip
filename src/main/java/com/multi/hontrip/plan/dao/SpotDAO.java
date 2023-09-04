package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.parser.Area;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SpotDAO {

    @Autowired
    SqlSessionTemplate my;

    // 여행지 추가
    public void insert(SpotDTO spotDTO){
        my.insert("spot.insert", spotDTO);
    }

    // 여행지 세부 정보 update
    public void update(SpotDTO spotDTO){
        my.update("spot.update", spotDTO);
    }
    
    // 단일 여행지 조회
    public SpotDTO one(String contentId){
        return my.selectOne("spot.one", contentId);
    }
    
    // 여행지 지역 목록 조회
    public List<SpotDTO> listWithAreaName(String areaName) {
        String areaCode = "";
        for (Area area : Area.values()) {
            if (area.getAreaName().contains(areaName)) {
                areaCode = area.getAreaCode();
            }
        }
        return my.selectList("spot.areaList", areaCode);
    }

    // 여행지 키워드 목록 조회
    public List<SpotDTO> listWithKeyword(String keyword) {
        return my.selectList("spot.keywordList", keyword);
    }
    
    // 여행지 조회 결과 카운트
    public int count(String keyword){
        return my.selectOne("spot.count", keyword);
    }

    // 여행지 개요 정보 존재 여부 조회
    public int checkSpotOverView(String contentId){
        return my.selectOne("spot.checkSpotOverview", contentId);
    }

    //
    public List<SpotDTO> listTopTenSpot(){
        return my.selectList("spot.listTopTenSpot");
    }
}
