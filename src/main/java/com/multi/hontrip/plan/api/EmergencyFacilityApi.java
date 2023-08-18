package com.multi.hontrip.plan.api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.multi.hontrip.plan.dto.EmergencyFacilityDTO;
import org.json.JSONArray;
import org.json.JSONObject;

// 카카오맵 api로 응급시설(병원|약국)정보 호출해 DB에 응답을 저장
public class EmergencyFacilityApi {
    public static void main(String[] args) {
        String kakaoApiKey = "";
        String categoryCodePharmacy = "PM9"; // 약국 카테고리
        String categoryCodeHospital = "HP8"; // 병원 카테고리
        String centerX = "127.027632"; // 서울
        String centerY = "37.497175";
        /*String centerX = "126.5422"; // 예시: 제주도 중심
        String centerY = "33.3647";*/
        /*String centerX = "128.2095"; // 예시: 강원도 중심
        String centerY = "37.5550";*/
        int radius = 20000; // 범위 20km

        try {
            List<EmergencyFacilityDTO> combinedResults = new ArrayList<>();

            // 약국 정보 요청
            JSONArray pharmacyResults = requestCategoryInfo(kakaoApiKey, categoryCodePharmacy, centerX, centerY, radius);
            for (int i = 0; i < pharmacyResults.length(); i++) {
                JSONObject item = pharmacyResults.getJSONObject(i);
                combinedResults.add(mapJsonToDTO(item));
            }

            // 병원 정보 요청
            JSONArray hospitalResults = requestCategoryInfo(kakaoApiKey, categoryCodeHospital, centerX, centerY, radius);
            for (int i = 0; i < hospitalResults.length(); i++) {
                JSONObject item = hospitalResults.getJSONObject(i);
                combinedResults.add(mapJsonToDTO(item));
            }

            // MySQL에 저장
            saveToMySQL(combinedResults);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static JSONArray requestCategoryInfo(String apiKey, String categoryCode, String centerX, String centerY, int radius) throws Exception {
        String apiUrl = "https://dapi.kakao.com/v2/local/search/category.json?category_group_code="
                + categoryCode
                + "&x="
                + centerX
                + "&y="
                + centerY
                + "&radius="
                + radius;
        URL url = new URL(apiUrl);

        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "KakaoAK " + apiKey);

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            response.append(line);
        }
        br.close();

        JSONObject jsonResponse = new JSONObject(response.toString());
        return jsonResponse.getJSONArray("documents");
    }

    private static EmergencyFacilityDTO mapJsonToDTO(JSONObject item) {
        EmergencyFacilityDTO dto = new EmergencyFacilityDTO();
        dto.setId(item.getString("id"));
        dto.setPlaceName(item.getString("place_name"));
        dto.setCategoryName(item.optString("category_name", ""));
        dto.setCategoryGroupCode(item.getString("category_group_code"));
        dto.setCategoryGroupName(item.getString("category_group_name"));
        dto.setPhone(item.optString("phone", ""));
        dto.setAddressName(item.getString("address_name"));
        dto.setRoadAddressName(item.optString("road_address_name", ""));
        dto.setX(item.getString("x"));
        dto.setY(item.getString("y"));
        dto.setPlaceUrl(item.optString("place_url", ""));
        dto.setDistance(item.optString("distance", ""));
        return dto;
    }

    private static void saveToMySQL(List<EmergencyFacilityDTO> data) throws Exception {
        String jdbcUrl = "jdbc:mysql://localhost:3306/hontrip?characterEncoding=UTF-8";
        String dbUser = "copidingz";
        String dbPassword = "qwer1234";

        Connection conn = null;
        try {
            conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

            for (EmergencyFacilityDTO dto : data) {
                // 만약 카테고리 이름이 아래의 경우 해당 정보를 저장하지 않고 건너뛰기
                if ("의료,건강 > 병원 > 노인,요양병원".equals(dto.getCategoryName()) ||
                        "의료,건강 > 병원 > 한방병원".equals(dto.getCategoryName()) ||
                        "의료,건강 > 병원 > 정신건강의학과".equals(dto.getCategoryName()) ||
                        "의료,건강 > 병원 > 성형외과".equals(dto.getCategoryName()) ||
                        "의료,건강 > 병원 > 피부과".equals(dto.getCategoryName()) ||
                        dto.getCategoryName().startsWith("의료,건강 > 병원 > 피부과 >")) {
                    continue;
                }

                String insertQuery = "INSERT INTO emergency_facility (id, place_name, category_name, category_group_code, category_group_name, phone, address_name, road_address_name, x, y, place_url, distance) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement preparedStatement = conn.prepareStatement(insertQuery)) {
                    preparedStatement.setString(1, dto.getId());
                    preparedStatement.setString(2, dto.getPlaceName());
                    preparedStatement.setString(3, dto.getCategoryName());
                    preparedStatement.setString(4, dto.getCategoryGroupCode());
                    preparedStatement.setString(5, dto.getCategoryGroupName());
                    preparedStatement.setString(6, dto.getPhone());
                    preparedStatement.setString(7, dto.getAddressName());
                    preparedStatement.setString(8, dto.getRoadAddressName());
                    preparedStatement.setString(9, dto.getX());
                    preparedStatement.setString(10, dto.getY());
                    preparedStatement.setString(11, dto.getPlaceUrl());
                    preparedStatement.setString(12, dto.getDistance());

                    try {
                        preparedStatement.executeUpdate();
                        System.out.println("Successfully inserted a row into the accommodation table.");
                    } catch (SQLException e) {
                        // 중복된 id가 이미 존재할 경우 에러를 무시하고 다음 값 저장
                        System.out.println("중복된 id 값이 이미 존재합니다. 다음 값으로 넘어갑니다.");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}