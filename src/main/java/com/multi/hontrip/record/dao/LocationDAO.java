package com.multi.hontrip.record.dao;

import com.multi.hontrip.record.dto.LocationDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class LocationDAO {

    private final SqlSessionTemplate sqlSessionTemplate;

    public List<LocationDTO> locationSelect() {
        return sqlSessionTemplate.selectList("record.locationList");
    }
}
