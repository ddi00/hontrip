package com.multi.hontrip.plan.controller;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.multi.hontrip.plan.service.SpotService;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.http.*;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import java.nio.charset.Charset;
import java.util.HashMap;
import java.util.Map;
@RestController
@RequestMapping("/plan")
public class SpotController {

    @Autowired
    SpotService spotService;

    @Autowired
    ApplicationContext ctx;

//    @RequestMapping("/spot")
//    public void insert(SpotParser parser) {
//
//        Environment env = ctx.getEnvironment();
//        String key = env.getProperty("spot.key");
//
//        for (int i = 0; i < 37; i++) {
//            ArrayList<SpotDTO> list = parser.parse(i, key);
//            for(SpotDTO spotVO : list) {
//                spotService.insert(spotVO);
//            }
//        }
//    }

    @GetMapping("/spot")
    public String callAPI() throws JsonProcessingException {

        JSONObject result = new JSONObject();

        String jsonInString = "";

        try {

            HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory();
            factory.setConnectTimeout(5000); //타임아웃 설정 5초
            factory.setReadTimeout(5000);//타임아웃 설정 5초
            RestTemplate restTemplate = new RestTemplate(factory);

            HttpHeaders header = new HttpHeaders();
            header.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
            HttpEntity<?> entity = new HttpEntity<>(header);

//            String url = "https://apis.data.go.kr/B551011/KorService1/areaBasedList1";
//            String serviceKey = "LoY3kyOBZldgm9ecrZSOwOA0XOkV4H5yDATpyTaUXVA5wQJD8VA%2B1js0fqWg3G0JlQGpW41LOGFsKGKdcj4EkQ%3D%3D";
//            String numOfRows = "20";
//            String pageNo = "1";
//            String MobileOS = "ETC";
//            String _type = "json";
//            String listYN = "Y";
//            String arrange = "A";
//            String contentTypeId = "12";
//            String areaCode = "39";
//
//            String param = "?serviceKey" + serviceKey
//                    + "&numOfRows=" + numOfRows
//                    + "&pageNo=" + pageNo
//                    + "&MobileOS=" + MobileOS
//                    + "&_type=" + _type
//                    + "&listYN=" + listYN
//                    + "&arrange=" + arrange
//                    + "&contentTypeId=" + contentTypeId
//                    + "&areaCode=" + areaCode;
//            url += param;

            UriComponents uri = UriComponentsBuilder.fromHttpUrl("https://apis.data.go.kr/B551011/KorService1/areaBasedList1?serviceKey=LoY3kyOBZldgm9ecrZSOwOA0XOkV4H5yDATpyTaUXVA5wQJD8VA%2B1js0fqWg3G0JlQGpW41LOGFsKGKdcj4EkQ%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&contentTypeId=12&areaCode=39").build();

            //이 한줄의 코드로 API를 호출해 MAP타입으로 전달 받는다.
            ResponseEntity<JSONObject> resultMap = restTemplate.exchange(uri.toString(), HttpMethod.GET, entity, JSONObject.class);
            result.put("statusCode", resultMap.getStatusCodeValue()); //http status code를 확인
            result.put("header", resultMap.getHeaders()); //헤더 정보 확인
            result.put("body", resultMap.getBody()); //실제 데이터 정보 확인

            //데이터를 제대로 전달 받았는지 확인 string형태로 파싱해줌
            ObjectMapper mapper = new ObjectMapper();
            jsonInString = mapper.writeValueAsString(resultMap.getBody());

        } catch (HttpClientErrorException | HttpServerErrorException e) {
            result.put("statusCode", e.getRawStatusCode());
            result.put("body"  , e.getStatusText());
            System.out.println("dfdfdfdf");
            System.out.println(e.toString());

        } catch (Exception e) {
            result.put("statusCode", "999");
            result.put("body"  , "excpetion오류");
            System.out.println(e.toString());
        }

        return jsonInString;
    }


}
