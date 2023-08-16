package com.multi.hontrip.plan.apitest;

import org.json.JSONArray;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

public class ApiTest8 {
    public static void main(String[] args) {
        // API 호출을 위한 기본 정보 설정
        String serviceKey = ""; // 발급받은 인증키를 입력해야 합니다.
        String baseUrl = "http://apis.data.go.kr/1741000/DisasterMsg4/getDisasterMsg2List";
        String type = "json"; // JSON 형식으로 응답 받습니다.
        String pageNo = "1"; // 페이지 번호
        String numOfRows = "10"; // 한 페이지당 요청 숫자
        String locationName = "제주"; // 원하는 수신지역 이름을 입력하세요.

        try {
            // URL 인코딩
            String encodedLocationName = URLEncoder.encode(locationName, "UTF-8");

            // API 호출 URL 생성
            String apiUrl = baseUrl + "?ServiceKey=" + serviceKey + "&type=" + type +
                    "&pageNo=" + pageNo + "&numOfRows=" + numOfRows +
                    "&location_name=" + encodedLocationName;

            // URL 객체 생성
            URL url = new URL(apiUrl);

            // HttpURLConnection 생성 및 설정
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            // Read and parse the JSON response
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
                StringBuilder response = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    response.append(line);
                }

                // Parse the JSON response
                JSONObject jsonResponse = new JSONObject(response.toString());

                // Get the array of messages
                JSONArray messages = jsonResponse.getJSONArray("DisasterMsg2").getJSONObject(1).getJSONArray("row");

                // Iterate through the messages and extract the desired fields
                for (int i = 0; i < messages.length(); i++) {
                    JSONObject message = messages.getJSONObject(i);
                    String createDate = message.getString("create_date");
                   // String locationName = message.getString("location_name");
                    String msg = message.getString("msg");

                    // Output the extracted data
                    System.out.println("Create Date: " + createDate);
                    System.out.println("Location Name: " + locationName);
                    System.out.println("Message: " + msg);
                    System.out.println();
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                connection.disconnect();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}