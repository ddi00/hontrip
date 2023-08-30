package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.EmergencyFacilityDTO;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class EmergencyFacilityDAO {
    @Autowired
    SqlSessionTemplate my;

    /*public void save(EmergencyFacilityDTO dto) {
        // MyBatis 매핑을 사용하여 DTO 데이터를 데이터베이스에 저장
        my.insert("emergency_facility.insert", dto);
    }*/

    public void save(EmergencyFacilityDTO dto) {
        // MyBatis 매핑을 사용하여 데이터베이스에 해당 id 값이 있는지 확인
        if (existsById(dto.getId())) {
            System.out.println("중복된 id 값이 이미 존재합니다. 다음 값으로 넘어갑니다.");
            return;
        }

        // 데이터베이스에 저장
        my.insert("emergency_facility.insert", dto);
    }

    private boolean existsById(String id) {
        return my.selectOne("emergency_facility.existsById", id) != null;
    }

    public EmergencyFacilityDTO one(Long EmergencyFacilityId) { // 응급시설 1개만 보기
        return my.selectOne("emergency_facility.one", EmergencyFacilityId);
    }  // 일정 하나

    public List<EmergencyFacilityDTO> list() { // 응급시설 리스트
        return my.selectList("emergency_facility.all");
    }

    public List<EmergencyFacilityDTO> filterByCategory(String categoryGroupName) { // 응급시설 카테고리 필터 (병원|약국)
        return my.selectList("emergency_facility.filterByCategory", categoryGroupName);
    }

    public List<EmergencyFacilityDTO> filterByAddress(String addressName) { // 응급시설 주소 필터
        return my.selectList("emergency_facility.filterByAddress", addressName);
    }

    public List<EmergencyFacilityDTO> filterByCategoryAndAddress(@Param("categoryGroupName") String categoryGroupName, @Param("addressName") String addressName) {
        Map<String, String> params = new HashMap<>();
        params.put("categoryGroupName", categoryGroupName);
        params.put("addressName", addressName);
        return my.selectList("emergency_facility.filterByCategoryAndAddress", params);
    } // 응급시설 주소|카테고리 필터
}
