package com.multi.hontrip.mate.dao;

import com.multi.hontrip.mate.dto.MateBoardInsertDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
@RequiredArgsConstructor
public class MateDAO {

    @Autowired
    SqlSessionTemplate my;

    public void mateBoardInsert(MateBoardInsertDTO mateBoardInsertDTO) {
        my.insert("mate.insert", mateBoardInsertDTO);
    }

    public MateBoardInsertDTO mateBoardSelectOne(int id) {
        return my.selectOne("mate.selectOne", id);
    }
}
