package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.AccommodationDAO;
import com.multi.hontrip.plan.dto.AccommodationDTO;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.*;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

@Service
@PropertySource("classpath:properties/plan/kakaomapApi.properties")
public class AccommodationServiceImpl implements AccommodationService {

    @Autowired
    AccommodationDAO accommodationDAO;

    @Autowired
    private RestTemplate restTemplate;

    /*private static final String KAKAO_MAP_API_KEY = "d8cf7eddeac8408c087d168ac8ede50c";*/

    @Value("${kakao.map.api.key}")
    private String KAKAO_MAP_API_KEY;
    private static final String KAKAO_MAP_API_URL = "https://dapi.kakao.com/v2/local/search/keyword.json";

    @Override
    @Async
    public void fetchAndSaveAccommodationData(String x, String y, int radius) {
        String query = "숙박";
        String responseFormat = "json"; // 또는 "xml" 사용 가능

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + KAKAO_MAP_API_KEY);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<String> response = restTemplate.exchange(
                KAKAO_MAP_API_URL + "?query=" + query + "&x=" + x + "&y=" + y + "&radius=" + radius + "&page=1&size=15&sort=accuracy&format=" + responseFormat,
                HttpMethod.GET,
                entity,
                String.class
        );

        if (response.getStatusCode() == HttpStatus.OK) {
            String responseBody = response.getBody();
            // JSON 응답을 파싱하고 필요한 필드 값을 데이터베이스에 저장
            parseAndSaveToDatabase(responseBody);
        } else {
            // Handle error
            System.out.println("Error: " + response.getStatusCode());
        }
    }

    private static void parseAndSaveToDatabase(String responseBody) {
        try {
            JSONObject responseObject = new JSONObject(responseBody);

            JSONArray documents = responseObject.getJSONArray("documents");

            for (int i = 0; i < documents.length(); i++) {
                JSONObject document = documents.getJSONObject(i);

                // 필요한 필드 값을 추출
                String placeName = document.getString("place_name");
                String addressName = document.getString("address_name");
                String categoryGroupCode = document.getString("category_group_code");
                String categoryGroupName = document.getString("category_group_name");
                String categoryName = document.getString("category_name");
                String distance = document.getString("distance");
                String id = document.getString("id");
                String phone = document.optString("phone", "");
                String placeUrl = document.optString("place_url", "");
                String roadAddressName = document.optString("road_address_name", "");
                String xCoord = document.getString("x");
                String yCoord = document.getString("y");

                // 데이터베이스에 저장
                AccommodationDTO accommodationDTO = new AccommodationDTO();
                accommodationDTO.setId(id);
                accommodationDTO.setPlaceName(placeName);
                accommodationDTO.setCategoryGroupName(categoryGroupName);
                accommodationDTO.setCategoryGroupCode(categoryGroupCode);
                accommodationDTO.setCategoryName(categoryName);
                accommodationDTO.setPhone(phone);
                accommodationDTO.setAddressName(addressName);
                accommodationDTO.setRoadAddressName(roadAddressName);
                accommodationDTO.setX(xCoord);
                accommodationDTO.setY(yCoord);
                accommodationDTO.setPlaceUrl(placeUrl);
                accommodationDTO.setDistance(distance);
                saveToDatabase(accommodationDTO);
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }

    // accommodation 테이블에 데이터를 저장하는 메서드
    private static void saveToDatabase(AccommodationDTO accommodationDTO) {
        // MySQL 연결 설정 (실제 설정에 맞게 수정 필요)
        String url = "jdbc:mysql://localhost:3306/hontrip?characterEncoding=UTF-8";
        String username = "copidingz";
        String password = "qwer1234";

        Connection connection = null;
        try {
            connection = DriverManager.getConnection(url, username, password);
            // INSERT 쿼리 작성
            String insertQuery = "INSERT INTO accommodation (id, place_name, category_name, category_group_code, category_group_name, phone, address_name, road_address_name, x, y, place_url, distance) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            // PreparedStatement 생성
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                preparedStatement.setString(1, accommodationDTO.getId());
                preparedStatement.setString(2, accommodationDTO.getPlaceName());
                preparedStatement.setString(3, accommodationDTO.getCategoryName());
                preparedStatement.setString(4, accommodationDTO.getCategoryGroupCode());
                preparedStatement.setString(5, accommodationDTO.getCategoryGroupName());
                preparedStatement.setString(6, accommodationDTO.getPhone());
                preparedStatement.setString(7, accommodationDTO.getAddressName());
                preparedStatement.setString(8, accommodationDTO.getRoadAddressName());
                preparedStatement.setString(9, accommodationDTO.getX());
                preparedStatement.setString(10, accommodationDTO.getY());
                preparedStatement.setString(11, accommodationDTO.getPlaceUrl());
                preparedStatement.setString(12, accommodationDTO.getDistance());

                try {
                    preparedStatement.executeUpdate();
                    System.out.println("Successfully inserted a row into the accommodation table.");
                } catch (SQLException e) {
                    // 중복된 id가 이미 존재할 경우 에러를 무시하고 다음 값 저장
                    System.out.println("중복된 id 값이 이미 존재합니다. 다음 값으로 넘어갑니다.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }


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
