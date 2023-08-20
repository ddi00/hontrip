package com.multi.hontrip.mate.dao;

import com.multi.hontrip.mate.dto.*;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MateDAO {
    @Autowired
    SqlSessionTemplate my;

    public List<MateBoardListDTO> list(MatePageDTO pageDTO) {

        return my.selectList("mateBbs.list", pageDTO);
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

    public int insertMatchingAlarm(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        return my.insert("mateBbs.insertMateMatchingAlarm", mateMatchingAlarmDTO);
    }

    public int checkApply(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        int num = my.selectOne("mateBbs.checkApply", mateMatchingAlarmDTO);
        System.out.println(num);
        return my.selectOne("mateBbs.checkApply", mateMatchingAlarmDTO);
    }


//    //게시물 1개 검색
//    public BbsDTO one(int id) {
//        return my.selectOne("bbs.one", id);
//    }
}