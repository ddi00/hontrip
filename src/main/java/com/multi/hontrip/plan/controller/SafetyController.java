package com.multi.hontrip.plan.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.stereotype.Controller;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Map;
import com.fasterxml.jackson.databind.ObjectMapper;

// 공공데이터 open api
// 재난문자방송 발령현황 조회(지역별) api
// 유저가 지역 입력 시 실시간으로 해당 지역 재난문자 받아와 보여줌
@Controller
@RequestMapping("/plan")
public class SafetyController {

    private static final String SERVICE_KEY = "";
    private static final String BASE_URL = "http://apis.data.go.kr/1741000/DisasterMsg4/getDisasterMsg2List";
    private static final String API_TYPE = "json";
    private static final String PAGE_NO = "1";
    private static final String NUM_OF_ROWS = "10";

    @GetMapping("/safety_search") // 유저가 지역 검색
    public String searchForm() {
        return "/plan/safety_search";
    }

    @GetMapping("/safety_result")
    public String searchResult(@RequestParam("locationName") String locationName, Model model) {
        try {
            String encodedLocationName = URLEncoder.encode(locationName, "UTF-8");

            // 현재 날짜를 가져옴
            LocalDate currentDate = LocalDate.now();
            String formattedDate = currentDate.format(DateTimeFormatter.ofPattern("yyyy/MM/dd"));

            String apiUrl = BASE_URL + "?ServiceKey=" + SERVICE_KEY + "&type=" + API_TYPE +
                    "&pageNo=" + PAGE_NO + "&numOfRows=" + NUM_OF_ROWS +
                    "&location_name=" + encodedLocationName + "&create_date=" + formattedDate;

            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            StringBuilder responseContent = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    responseContent.append(line);
                }
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                connection.disconnect();
            }

            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> result = objectMapper.readValue(responseContent.toString(), Map.class);

            model.addAttribute("locationName", locationName);
            model.addAttribute("result", result.get("DisasterMsg2"));

            return "/plan/safety_result";
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            model.addAttribute("error", "입력값 처리 중 에러 발생");
            return "/error";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "API 호출 중 에러 발생");
            return "/error";
        }
    }

    @ExceptionHandler(UnsupportedEncodingException.class)
    public String handleUnsupportedEncodingException(Model model) {
        model.addAttribute("error", "입력값 처리 중 에러 발생");
        return "/error";
    }

    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, Model model) {
        e.printStackTrace();
        model.addAttribute("error", "API 호출 중 에러 발생");
        return "/error";
    }
}
