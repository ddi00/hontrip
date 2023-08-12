package com.multi.hontrip.mate.dao;

import com.multi.hontrip.mate.dto.LocationDTO;
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

        return my.selectList("bbs.list", pageDTO);
    }
    public int count() {
        return my.selectOne("bbs.count");
    }

    public List<LocationDTO> location(){
        return my.selectList("bbs.location");
    }

//    //게시물 1개 검색
//    public BbsDTO one(int id) {
//        return my.selectOne("bbs.one", id);
//    }
}
