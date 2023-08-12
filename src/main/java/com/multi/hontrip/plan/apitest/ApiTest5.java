package com.multi.hontrip.plan.apitest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

public class ApiTest5 {
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
            // JSON 응답을 파싱하고 필요한 필드 값을 출력
            parseAndProcessJsonResponse(responseBody);
        } else {
            System.out.println("Error: " + response.getStatusCode());
        }
    }

    // JSON 응답을 파싱하고 필요한 필드 값을 출력하는 메서드
    private static void parseAndProcessJsonResponse(String responseBody) {
        try {
            JSONArray documents = new JSONObject(responseBody).getJSONArray("documents");

            for (int i = 0; i < documents.length(); i++) {
                JSONObject document = documents.getJSONObject(i);
                String addressName = document.getString("address_name");
                String categoryGroupCode = document.getString("category_group_code");
                String categoryGroupName = document.getString("category_group_name");
                String categoryName = document.getString("category_name");
                String distance = document.getString("distance");
                String id = document.getString("id");
                String phone = document.getString("phone");
                String placeName = document.getString("place_name");
                String placeUrl = document.getString("place_url");
                String roadAddressName = document.getString("road_address_name");
                String xCoord = document.getString("x");
                String yCoord = document.getString("y");

                System.out.println("장소명: " + placeName);
                System.out.println("주소: " + addressName);
                System.out.println("카테고리 그룹 코드: " + categoryGroupCode);
                System.out.println("카테고리 그룹 이름: " + categoryGroupName);
                System.out.println("카테고리 이름: " + categoryName);
                System.out.println("거리: " + distance);
                System.out.println("ID: " + id);
                System.out.println("전화번호: " + phone);
                System.out.println("장소 URL: " + placeUrl);
                System.out.println("도로명 주소: " + roadAddressName);
                System.out.println("X 좌표: " + xCoord);
                System.out.println("Y 좌표: " + yCoord);
                System.out.println("==============================");
            }
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}