package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.AccommodationDTO;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class AccommodationDAO {

    @Autowired
    SqlSessionTemplate my;

    public AccommodationDTO one(Long accommodationId) { // 숙박시설 1개만 보기
        return my.selectOne("accommodation.one", accommodationId);
    }

    public List<AccommodationDTO> list() { // 숙박시설 리스트
        return my.selectList("accommodation.all");
    }

    public List<AccommodationDTO> filterByAddress(String addressName) { // 숙박시설 주소 필터
        return my.selectList("accommodation.filterByAddress", addressName);
    }

    public List<AccommodationDTO> filterByPlaceName(String placeName) { // 숙박시설 이름 필터
        return my.selectList("accommodation.filterByPlaceName", placeName);
    }

    public List<AccommodationDTO> filterByCategory(String categoryName) { // 숙박시설 카테고리 필터 (호텔|펜션|콘도,리조트|야영,캠핑장)
        return my.selectList("accommodation.filterByCategory", categoryName);
    }

    public List<AccommodationDTO> filterByAddressAndPlaceName(@Param("addressName") String addressName, @Param("placeName") String placeName){
        Map<String, String> params = new HashMap<>();
        params.put("addressName", addressName);
        params.put("placeName", placeName);
        return my.selectList("accommodation.filterByAddressAndPlaceName", params);
    } // 숙박시설 주소|이름 필터

    public List<AccommodationDTO> filterByAddressAndCategoryName(@Param("addressName") String addressName, @Param("categoryName") String categoryName){
        Map<String, String> params = new HashMap<>();
        params.put("addressName", addressName);
        params.put("categoryName", categoryName);
        return my.selectList("accommodation.filterByAddressAndCategoryName", params);
    } // 숙박시설 주소|카테고리 필터

    public List<AccommodationDTO> filterByPlaceNameAndCategoryName(@Param("placeName") String placeName, @Param("categoryName") String categoryName){
        Map<String, String> params = new HashMap<>();
        params.put("placeName", placeName);
        params.put("categoryName", categoryName);
        return my.selectList("accommodation.filterByPlaceNameAndCategoryName", params);
    }

    public List<AccommodationDTO> filterByCategoryAndPlaceNameAndAddress(@Param("categoryName") String categoryName,  @Param("placeName") String placeName, @Param("addressName") String addressName){
        Map<String, String> params = new HashMap<>();
        params.put("categoryName", categoryName);
        params.put("placeName", placeName);
        params.put("addressName", addressName);
        return my.selectList("accommodation.filterByCategoryAndPlaceNameAndAddress", params);
    } // 숙박시설 주소|카테고리 필터

    public List<AccommodationDTO> searchAccommodationsWithFilter(@Param("query") String query) {
        Map<String, Object> params = new HashMap<>();
        params.put("query", "%" + query + "%");


        return my.selectList("accommodationMapper.searchAccommodationsWithFilter", params);
    }

}
