package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.AccommodationDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AccommodationDAO {

    @Autowired
    SqlSessionTemplate my;

    public AccommodationDTO one(Long accommodationId) {
        return my.selectOne("accommodation.one", accommodationId);
    }  // 일정 하나

    public List<AccommodationDTO> list() {
        return my.selectList("accommodation.all");
    }  // 숙소 리스트(전체)
}
