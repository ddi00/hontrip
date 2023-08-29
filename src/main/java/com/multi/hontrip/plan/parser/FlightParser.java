package com.multi.hontrip.plan.parser;

import com.multi.hontrip.plan.dto.FlightDTO;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;


import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Component
@PropertySource("classpath:properties/plan/openApi.properties")
public class FlightParser {
    @Value("${openapi.service_key}")
    private String SERVICE_KEY;

    //태그 값 얻는 메소드
    private static String getTagValue(String tag, Element element) {
        NodeList nodeList = element.getElementsByTagName(tag).item(0).getChildNodes();
        Node nodeValue = (Node) nodeList.item(0);
        if (nodeValue == null) {
            return null;
        }
        return nodeValue.getNodeValue();
    }

    // 사용자 입력 공항명(한글) - 공항 ID 맵핑하기 위한 메소
    public static String findAirportIdByAirportName(String airportName) {
        for (Airport airport : Airport.values()) {
            if (airport.getAirportName().equals(airportName)) {
                return airport.getAirportId();
            }
        }
        return null;
    }

    // 항공편 api 호출 및 데이터 파싱
    public List<FlightDTO> parseData(String depAirport, String arrAirport, Date depDate) throws IOException, ParserConfigurationException, SAXException {
        List<FlightDTO> list = new ArrayList<>();
        String parsingUrl = "";

        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        String departure_date = format.format(depDate); // 출발일 yyyyMMdd 형식으로 formatting

        String departure_airport_id = findAirportIdByAirportName(depAirport);
        String arrival_airport_id = findAirportIdByAirportName(arrAirport);

        int pageNo = 1;

        try {
            while (true) {
                StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getFlightOpratInfoList"); // URL
                urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + SERVICE_KEY); // Service Key
                urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(String.valueOf(pageNo), "UTF-8")); // 페이지번호
                urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); // 한 페이지 결과 수
                urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); // 데이터 타입
                urlBuilder.append("&" + URLEncoder.encode("depAirportId", "UTF-8") + "=" + URLEncoder.encode(departure_airport_id, "UTF-8")); // 출발공항 ID
                urlBuilder.append("&" + URLEncoder.encode("arrAirportId", "UTF-8") + "=" + URLEncoder.encode(arrival_airport_id, "UTF-8")); // 도착공항 ID
                urlBuilder.append("&" + URLEncoder.encode("depPlandTime", "UTF-8") + "=" + URLEncoder.encode(departure_date, "UTF-8")); //출발일(YYYYMMDD)
                //urlBuilder.append("&" + URLEncoder.encode("airlineId", "UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); // 항공사 ID - 미지정시 전체 항공사 대상

                URL url = new URL(urlBuilder.toString());
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Content-type", "application/json");
                System.out.println("Response code: " + conn.getResponseCode());
                conn.disconnect();

                parsingUrl = url.toString();
                System.out.println(parsingUrl);

                // 페이지에 접근할 Document 객체 생성, 파싱할 url 요소 읽기
                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder docBuilder = dbFactory.newDocumentBuilder();
                Document doc = docBuilder.parse(parsingUrl);

                // root tag
                doc.getDocumentElement().normalize(); // xml 루트 요소 정규화

                NodeList nodeList = doc.getElementsByTagName("item");   // 태그명 item
                System.out.println("the number of parsing items : " + nodeList.getLength());

                // 파싱 대상 수만큼 for문 반복
                for (int i = 0; i < nodeList.getLength(); i++) {
                    Node node = nodeList.item(i);
                    if (node.getNodeType() == Node.ELEMENT_NODE) { // 노드 타입 element 여부 확인
                        Element element = (Element) node;
                        FlightDTO flightDTO = new FlightDTO();

                        // tag value 읽어와 dto에 set
                        flightDTO.setVehicleId(getTagValue("vihicleId", element));
                        flightDTO.setAirlineName(getTagValue("airlineNm", element));
                        flightDTO.setDepAirportName(getTagValue("depAirportNm", element));
                        flightDTO.setDepartureTime(getTagValue("depPlandTime", element));
                        flightDTO.setArrAirportName(getTagValue("arrAirportNm", element));
                        flightDTO.setArrivalTime(getTagValue("arrPlandTime", element));

                        // 일부 항공사 운임 정보 미제공하여 NullPointerException 발생 가능하므로 예외 처리
                        try {
                            flightDTO.setEconomyCharge(getTagValue("economyCharge", element));
                        } catch (NullPointerException e) {
                            flightDTO.setEconomyCharge("0");  // economyCharge 값이 null이면 0 set
                        }
                        try {
                            flightDTO.setPrestigeCharge(getTagValue("prestigeCharge", element));
                        } catch (NullPointerException e) {
                            flightDTO.setPrestigeCharge("0"); // prestigeCharge 값이 null이면 0 set
                        }
                        list.add(flightDTO);
                    }
                }
                pageNo += 1;
                if (pageNo > 2) { // 2 페이지 넘어가면 while문 break
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}