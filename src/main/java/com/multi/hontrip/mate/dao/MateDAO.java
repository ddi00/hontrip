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

    public MateBoardListDTO one(long mateBoardId) {
        return my.selectOne("mateBbs.one", mateBoardId);
    }

    public int count(PageDTO pageDTO) {
        return my.selectOne("mateBbs.count", pageDTO);
    }

    public List<LocationDTO> location() {
        return my.selectList("mateBbs.location");
    }


}
