package com.multi.hontrip.plan.apitest;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ApiTest6 {
    private static final String KAKAO_MAP_API_KEY = "";
    private static final String KAKAO_MAP_API_URL = "https://dapi.kakao.com/v2/local/search/keyword.json";

    public static void main(String[] args) {
        // 원하는 중심 좌표 (경도, 위도)와 반경 설정
        String x = "126.9784"; // 예시: 서울 중심
        String y = "37.5665";
        int radius = 20000; // 반경 20km

        String query = "숙박";
        String responseFormat = "json"; // 또는 "xml" 사용 가능

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + KAKAO_MAP_API_KEY);

        HttpEntity<String> entity = new HttpEntity<>(headers);

        RestTemplate restTemplate = new RestTemplate();
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
            System.out.println("Error: " + response.getStatusCode());
        }
    }

    // JSON 응답을 파싱하고 필요한 필드 값을 데이터베이스에 저장하는 메서드
    private static void parseAndSaveToDatabase(String responseBody) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(responseBody);

            // documents 배열에서 필드 값을 추출하여 데이터베이스에 저장
            JsonNode documentsNode = rootNode.get("documents");
            if (documentsNode.isArray()) {
                for (JsonNode documentNode : documentsNode) {
                    // 필요한 필드 값을 추출
                    String placeName = documentNode.get("place_name").asText();
                    String addressName = documentNode.get("address_name").asText();
                    String categoryGroupCode = documentNode.get("category_group_code").asText();
                    String categoryGroupName = documentNode.get("category_group_name").asText();
                    String categoryName = documentNode.get("category_name").asText();
                    String distance = documentNode.get("distance").asText();
                    String id = documentNode.get("id").asText();
                    String phone = documentNode.get("phone").asText();
                    String placeUrl = documentNode.get("place_url").asText();
                    String roadAddressName = documentNode.get("road_address_name").asText();
                    String xCoord = documentNode.get("x").asText();
                    String yCoord = documentNode.get("y").asText();

                    // 데이터베이스에 저장
                    saveToDatabase(id, placeName, categoryGroupName, categoryGroupCode,
                            categoryName, phone, addressName, roadAddressName,
                            xCoord, yCoord, placeUrl, distance);
                }
            } else {
                System.out.println("No documents found.");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // accommodation 테이블에 데이터를 저장하는 메서드
    private static void saveToDatabase(String id, String placeName, String categoryGroupName, String categoryGroupCode,
                                       String categoryName, String phone, String addressName, String roadAddressName,
                                       String xCoord, String yCoord, String placeUrl, String distance) {
        // MySQL 연결 설정 (실제 설정에 맞게 수정 필요)
        String url = "";
        String username = "";
        String password = "";

        try (Connection connection = DriverManager.getConnection(url, username, password)) {
            // INSERT 쿼리 작성
            String insertQuery = "INSERT INTO accommodation (id, place_name, category_name, category_group_code, category_group_name, phone, address_name, road_address_name, x, y, place_url, distance) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            // PreparedStatement 생성
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                preparedStatement.setString(1, id);
                preparedStatement.setString(2, placeName);
                preparedStatement.setString(3, categoryName);
                preparedStatement.setString(4, categoryGroupCode);
                preparedStatement.setString(5, categoryGroupName);
                preparedStatement.setString(6, phone);
                preparedStatement.setString(7, addressName);
                preparedStatement.setString(8, roadAddressName);
                preparedStatement.setString(9, xCoord);
                preparedStatement.setString(10, yCoord);
                preparedStatement.setString(11, placeUrl);
                preparedStatement.setString(12, distance);

                // INSERT 쿼리 실행
                int rowsAffected = preparedStatement.executeUpdate();
                System.out.println("Inserted " + rowsAffected + " row(s) into accommodation table.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}