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

    public void mateBoardInsert(MateBoardInsertDTO mateBoardInsertDTO) {
        my.insert("mateBbs.insert", mateBoardInsertDTO);
    }

    public MateBoardInsertDTO mateBoardSelectOne(long id) {
        return my.selectOne("mateBbs.selectOne", id);
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


    public List<MateBoardListDTO> list(PageDTO pageDTO) {

        return my.selectList("mateBbs.list", pageDTO);
    }

    public int count() {
        return my.selectOne("mateBbs.count");
    }

    public List<LocationDTO> location() {
        return my.selectList("mateBbs.location");
    }

//    //게시물 1개 검색
//    public BbsDTO one(int id) {
//        return my.selectOne("bbs.one", id);
//    }
}
