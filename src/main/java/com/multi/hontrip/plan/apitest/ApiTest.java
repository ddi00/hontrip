package com.multi.hontrip.plan.apitest;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.JSONArray;
import org.json.JSONObject;

public class ApiTest {
    public static void main(String[] args) {
        // 카카오 REST API 키
        String kakaoApiKey = "d8cf7eddeac8408c087d168ac8ede50c";
        // 카테고리 코드 (PM9: 약국, HP8: 병원)
        String categoryCodePharmacy = "PM9";
        String categoryCodeHospital = "HP8";
        // 중심 좌표 (예: 강남역)
        String centerX = "127.027632";
        String centerY = "37.497175";
        // 반경 (20km)
        int radius = 20000;

        try {
            // 약국 정보 요청
            JSONArray pharmacyResults = requestCategoryInfo(kakaoApiKey, categoryCodePharmacy, centerX, centerY, radius);

            // 병원 정보 요청
            JSONArray hospitalResults = requestCategoryInfo(kakaoApiKey, categoryCodeHospital, centerX, centerY, radius);

            // 결과 합치기
            JSONArray combinedResults = new JSONArray();
            for (int i = 0; i < pharmacyResults.length(); i++) {
                combinedResults.put(pharmacyResults.getJSONObject(i));
            }
            for (int i = 0; i < hospitalResults.length(); i++) {
                combinedResults.put(hospitalResults.getJSONObject(i));
            }

            // 합친 결과 출력
            System.out.println(combinedResults.toString(2));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static JSONArray requestCategoryInfo(String apiKey, String categoryCode, String centerX, String centerY, int radius) throws Exception {
        // URL 생성
        String apiUrl = "https://dapi.kakao.com/v2/local/search/category.json?category_group_code="
                + categoryCode
                + "&x="
                + centerX
                + "&y="
                + centerY
                + "&radius="
                + radius;
        URL url = new URL(apiUrl);

        // HTTP 연결 설정
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Authorization", "KakaoAK " + apiKey);

        // 응답 읽기
        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder response = new StringBuilder();
        String line;
        while ((line = br.readLine()) != null) {
            response.append(line);
        }
        br.close();

        // JSON 파싱
        JSONObject jsonResponse = new JSONObject(response.toString());
        JSONArray documents = jsonResponse.getJSONArray("documents");

        // 연결 해제
        conn.disconnect();

        return documents;
    }
}
