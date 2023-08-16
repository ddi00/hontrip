package com.multi.hontrip.plan.apitest;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

public class ApiTest2 {
    public static void main(String[] args) {
        String kakaoApiKey = "";
        String categoryCodePharmacy = "PM9";
        String categoryCodeHospital = "HP8";
        String centerX = "127.027632";
        String centerY = "37.497175";
        int radius = 20000;

        try {
            List<JSONObject> combinedResults = new ArrayList<>();

            // 약국 정보 요청
            JSONArray pharmacyResults = requestCategoryInfo(kakaoApiKey, categoryCodePharmacy, centerX, centerY, radius);
            for (int i = 0; i < pharmacyResults.length(); i++) {
                combinedResults.add(pharmacyResults.getJSONObject(i));
            }

            // 병원 정보 요청
            JSONArray hospitalResults = requestCategoryInfo(kakaoApiKey, categoryCodeHospital, centerX, centerY, radius);
            for (int i = 0; i < hospitalResults.length(); i++) {
                combinedResults.add(hospitalResults.getJSONObject(i));
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

    private static void saveToMySQL(List<JSONObject> data) throws Exception {
        String jdbcUrl = "jdbc:mysql://localhost:3306/hontrip?characterEncoding=UTF-8";
        String dbUser = "copidingz";
        String dbPassword = "qwer1234";

        try (Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword)) {
            for (JSONObject item : data) {
                String id = item.getString("id");
                String placeName = item.getString("place_name");
                String category = item.optString("category_name", ""); // "category_name" 키가 없는 경우 공백으로 초기화
                String categoryGroupCode = item.getString("category_group_code");
                String categoryGroupName = item.getString("category_group_name");
                String phone = item.optString("phone", "");
                String address = item.getString("address_name");
                String roadAddress = item.optString("road_address_name", ""); // "road_address_name" 키가 없는 경우 공백으로 초기화
                String x = item.getString("x");
                String y = item.getString("y");
                String placeUrl = item.optString("place_url", ""); // "place_url" 키가 없는 경우 공백으로 초기화
                String distance = item.optString("distance", ""); // "distance" 키가 없는 경우 공백으로 초기화

                String insertQuery = "INSERT INTO emergency_facility (id, place_name, category_name, category_group_code, category_group_name, phone, address_name, road_address_name, x, y, place_url, distance) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                try (PreparedStatement preparedStatement = conn.prepareStatement(insertQuery)) {
                    preparedStatement.setString(1, id);
                    preparedStatement.setString(2, placeName);
                    preparedStatement.setString(3, category);
                    preparedStatement.setString(4, categoryGroupCode);
                    preparedStatement.setString(5, categoryGroupName);
                    preparedStatement.setString(6, phone);
                    preparedStatement.setString(7, address);
                    preparedStatement.setString(8, roadAddress);
                    preparedStatement.setString(9, x);
                    preparedStatement.setString(10, y);
                    preparedStatement.setString(11, placeUrl);
                    preparedStatement.setString(12, distance);

                    preparedStatement.executeUpdate();
                }
            }
        }
    }
}