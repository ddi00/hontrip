package com.multi.hontrip.mate.dao;

import com.multi.hontrip.mate.dto.LocationDTO;
import com.multi.hontrip.mate.dto.MateBoardInsertDTO;
import com.multi.hontrip.mate.dto.MateBoardListDTO;
import com.multi.hontrip.mate.dto.PageDTO;
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

    public MateBoardInsertDTO mateBoardSelectOne(int id) {
        return my.selectOne("mateBbs.selectOne", id);
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
