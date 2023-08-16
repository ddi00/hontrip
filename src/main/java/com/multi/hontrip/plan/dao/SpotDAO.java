package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.SpotDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SpotDAO {

    @Autowired
    SqlSessionTemplate my;

    public void insert(SpotDTO spotDTO){
        my.insert("spot.insert", spotDTO);
    }
}
