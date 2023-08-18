package com.multi.hontrip.mate.dao;

import com.multi.hontrip.mate.dto.LocationDTO;
import com.multi.hontrip.mate.dto.MateBoardInsertDTO;
import com.multi.hontrip.mate.dto.MateBoardListDTO;
import com.multi.hontrip.mate.dto.PageDTO;
import org.springframework.stereotype.Repository;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Repository
public class MateDAO {
    @Autowired
    SqlSessionTemplate my;

    public List<MateBoardListDTO> list(PageDTO pageDTO) {

        return my.selectList("mateBbs.list", pageDTO);
    }

    public MateBoardListDTO one(long mateBoardId) {
        return my.selectOne("mateBbs.one", mateBoardId);
    }

    public int count(PageDTO pageDTO) {
        return my.selectOne("mateBbs.count", pageDTO);
    }

    public List<LocationDTO> location() {
        return my.selectList("mateBbs.location");
    }

    public void mateBoardInsert(MateBoardInsertDTO mateBoardInsertDTO) {
        my.insert("mateBbs.insert", mateBoardInsertDTO);
    }

    public MateBoardInsertDTO mateBoardSelectOne(int id) {
        return my.selectOne("mateBbs.selectOne", id);
    }
}