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
        return "plan/safety_search";
    }

    @GetMapping("/safety_result") // 검색한 지역 내 api 호출해서 재난문자 보여줌
    public String searchResult(@RequestParam("locationName") String locationName, Model model) {
        try {
            String encodedLocationName = URLEncoder.encode(locationName, "UTF-8");
            String apiUrl = BASE_URL + "?ServiceKey=" + SERVICE_KEY + "&type=" + API_TYPE +
                    "&pageNo=" + PAGE_NO + "&numOfRows=" + NUM_OF_ROWS +
                    "&location_name=" + encodedLocationName;

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

            // JSON 데이터를 Map으로 파싱하여 리턴
            ObjectMapper objectMapper = new ObjectMapper();
            Map<String, Object> result = objectMapper.readValue(responseContent.toString(), Map.class);

            // Model에 데이터 추가
            model.addAttribute("locationName", locationName);
            model.addAttribute("result", result.get("DisasterMsg2"));

            return "plan/safety_result"; // result.jsp로 리턴
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            // 예외 처리 필요
            model.addAttribute("error", "입력값 처리 중 에러 발생");
            return "error"; // 에러 페이지로 리턴
        } catch (Exception e) {
            e.printStackTrace();
            // 예외 처리 필요
            model.addAttribute("error", "API 호출 중 에러 발생");
            return "error"; // 에러 페이지로 리턴
        }
    }

    // 컨트롤러 내에서의 예외 처리
    @ExceptionHandler(UnsupportedEncodingException.class)
    public String handleUnsupportedEncodingException(Model model) {
        model.addAttribute("error", "입력값 처리 중 에러 발생");
        return "error"; // 에러 페이지로 리턴
    }

    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, Model model) {
        e.printStackTrace();
        model.addAttribute("error", "API 호출 중 에러 발생");
        return "error"; // 에러 페이지로 리턴
    }
}

