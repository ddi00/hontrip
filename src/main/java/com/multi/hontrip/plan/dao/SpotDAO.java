package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.parser.Area;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class SpotDAO {

    @Autowired
    SqlSessionTemplate my;

    public void insert(SpotDTO spotDTO){
        my.insert("spot.insert", spotDTO);
    }

    public List<SpotDTO> list(@Param("areaName") String areaName) {
        String areaCode = "";
        for (Area area : Area.values()) {
            if (area.getAreaName().contains(areaName)) {
                areaCode = area.getAreaCode();
            }
        }
        return my.selectList("spot.list", areaCode);
    }
}
