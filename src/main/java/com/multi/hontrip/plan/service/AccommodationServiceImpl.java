package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.AccommodationDAO;
import com.multi.hontrip.plan.dto.AccommodationDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class AccommodationServiceImpl implements AccommodationService {

    @Autowired
    AccommodationDAO accommodationDAO;

    @Override
    public AccommodationDTO one(Long accommodationId) {
        return accommodationDAO.one(accommodationId);
    } // 숙박시설 하나만 보기

    @Override
    public List<AccommodationDTO> list() {
        return accommodationDAO.list();
    } // 숙박시설 list

    @Override
    public List<AccommodationDTO> filterByAddress(String addressName) { // 숙박시설 주소 필터
        return accommodationDAO.filterByAddress(addressName);
    }

    @Override
    public List<AccommodationDTO> filterByPlaceName(String placeName) { // 숙박시설 이름 필터
        return accommodationDAO.filterByPlaceName(placeName);
    }

    @Override
    public List<AccommodationDTO> filterByCategory(String categoryName) { // 숙박시설 카테고리 필터 (호텔|펜션|콘도,리조트|야영,캠핑장)
        return accommodationDAO.filterByCategory(categoryName);
    }

    @Override
    public List<AccommodationDTO> filterByAddressAndPlaceName(String addressName, String placeName) { // 숙박시설 주소|이름 필터
        return accommodationDAO.filterByAddressAndPlaceName(addressName, placeName);
    }

    @Override
    public List<AccommodationDTO> filterByAddressAndCategoryName(String addressName, String categoryName) { // 숙박시설 주소|카테고리 필터
        return accommodationDAO.filterByAddressAndCategoryName(addressName, categoryName);
    }

  /*  @Override
    public List<AccommodationDTO> filterByPlaceNameAndCategoryName(String placeName, String categoryName) { // 숙박시설 주소|카테고리 필터
        return accommodationDAO.filterByPlaceNameAndCategoryName(placeName, categoryName);
    }*/

  /*  @Override
    public List<AccommodationDTO> filterByCategoryAndPlaceNameAndAddress(String addressName, String categoryName, String placeName) { // 숙박시설 주소|카테고리 필터
        return accommodationDAO.filterByCategoryAndPlaceNameAndAddress(addressName, categoryName, placeName);

    }*/


}
