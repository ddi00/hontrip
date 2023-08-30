package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.AccommodationDTO;

import java.util.List;

public interface AccommodationService {

    void fetchAndSaveAccommodationData(String x, String y, int radius);
    AccommodationDTO one(Long accommodationId); // id별 숙박시설 하나
    List<AccommodationDTO> list(); // 숙박시설 리스트
    List<AccommodationDTO> filterByAddress(String addressName); // 숙박시설 주소 필터
    List<AccommodationDTO> filterByPlaceName(String placeName); // 숙박시설 이름 필터
    List<AccommodationDTO> filterByCategory(String categoryName); // 숙박시설 카테고리 필터 (호텔|펜션|콘도,리조트|야영,캠핑장)
    List<AccommodationDTO> filterByAddressAndPlaceName(String addressName, String placeName); // 숙박시설 주소|이름 필터

    List<AccommodationDTO> filterByAddressAndCategoryName(String addressName, String categoryName); // 숙박시설 주소|카테고리 필터

  /*  List<AccommodationDTO> filterByPlaceNameAndCategoryName(String placeName, String categoryName); // 숙박시설 주소|카테고리 필터

    List<AccommodationDTO> filterByCategoryAndPlaceNameAndAddress(String addressName, String categoryName, String placeName); // 숙박시설 주소|카테고리 필터
*/



}
