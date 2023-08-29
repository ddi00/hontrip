package com.multi.hontrip.mate.dao;

import com.multi.hontrip.mate.dto.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class MateDAO {
    @Autowired
    SqlSessionTemplate my;

    public List<MateBoardListDTO> list(MatePageDTO pageDTO) {
        Map<String,Object> param = new HashMap<>();

        param.put("searchType",pageDTO.getSearchType());
        param.put("keyword",pageDTO.getKeyword());
        param.put("start",pageDTO.getStart());
        param.put("end",pageDTO.getEnd());
        param.put("regionId", pageDTO.getRegionId());

        System.out.println("region -> " + pageDTO.getRegionId());
        return my.selectList("mateBbs.list", param);
    }

    public MateBoardListDTO one(long mateBoardId) {
        return my.selectOne("mateBbs.one", mateBoardId);
    }

    public int count(MatePageDTO pageDTO) {
        return my.selectOne("mateBbs.count", pageDTO);
    }

    public List<LocationDTO> location() {
        return my.selectList("mateBbs.location");
    }

    public void mateBoardInsert(MateBoardInsertDTO mateBoardInsertDTO) {
        my.insert("mateBbs.mateBoardInsert", mateBoardInsertDTO);
    }

    public MateBoardSelectOneDTO mateBoardSelectOne(long id) {
        return my.selectOne("mateBbs.mateBoardSelectOne", id);
    }

    public int updateMateBoard(MateBoardInsertDTO mateBoardInsertDTO) {
        return my.update("mateBbs.updateMateBoard", mateBoardInsertDTO);
    }

    public int deleteMateBoard(long id) {
        return my.delete("mateBbs.deleteMateBoard", id);
    }

    public UserGenderAgeDTO findUserGenderAgeById(long id) {
        return my.selectOne("mateBbs.findUserGenderAgeById", id);
    }

    public int checkApply(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        return my.selectOne("mateBbs.checkApply", mateMatchingAlarmDTO);
    }

    public List<MateBoardListDTO> regionList(MatePageDTO matePageDTO) {
        return my.selectList("mateBbs.regionList", matePageDTO);
    }


//    //게시물 1개 검색
//    public BbsDTO one(int id) {
//        return my.selectOne("bbs.one", id);
//    }
}