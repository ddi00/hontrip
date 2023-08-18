package com.multi.hontrip.plan.parser;

import com.multi.hontrip.plan.dto.FlightDTO;
import com.multi.hontrip.plan.service.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
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
public class FlightParser {

    private static final String SERVICE_KEY = "LoY3kyOBZldgm9ecrZSOwOA0XOkV4H5yDATpyTaUXVA5wQJD8VA%2B1js0fqWg3G0JlQGpW41LOGFsKGKdcj4EkQ%3D%3D"; // 서비스키 발급 필요

    //태그 값 얻는 메소드
    private static String getTagValue(String tag, Element element) {
        NodeList nodeList = element.getElementsByTagName(tag).item(0).getChildNodes();
        Node nodeValue = (Node) nodeList.item(0);
        if (nodeValue == null) {
            return null;
        }
        return nodeValue.getNodeValue();
    }

    // 데이터 파싱 메소드
    public List<FlightDTO> parseData(String depAirport, String arrAirport, Date depDate) throws IOException, ParserConfigurationException, SAXException {
        List<FlightDTO> list = new ArrayList<>();
        String parsingUrl = ""; // Parsing할 URL

        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        String departure_date = format.format(depDate); // 출발일 yyyyMMdd 형식으로 formatting
        // Airport enum
        Airport departure_airport = Airport.valueOf(depAirport);
        Airport arrival_airport = Airport.valueOf(arrAirport);

        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getFlightOpratInfoList"); // URL
        urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + SERVICE_KEY); // Service Key
        urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); // 페이지번호
        urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("200", "UTF-8")); // 한 페이지 결과 수
        urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); // 데이터 타입
        urlBuilder.append("&" + URLEncoder.encode("depAirportId", "UTF-8") + "=" + URLEncoder.encode(departure_airport.getAirportId(), "UTF-8")); // 출발공항 ID
        urlBuilder.append("&" + URLEncoder.encode("arrAirportId", "UTF-8") + "=" + URLEncoder.encode(arrival_airport.getAirportId(), "UTF-8")); // 도착공항 ID
        urlBuilder.append("&" + URLEncoder.encode("depPlandTime", "UTF-8") + "=" + URLEncoder.encode(departure_date, "UTF-8")); //출발일(YYYYMMDD)
        //urlBuilder.append("&" + URLEncoder.encode("airlineId", "UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); // 항공사 ID - 미지정시 전체 항공사 대상

        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());

//        BufferedReader rd;
//        if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
//            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//        } else {
//            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
//        }
//        StringBuilder sb = new StringBuilder();
//        String line;
//        while ((line = rd.readLine()) != null) {
//            sb.append(line);
//        }
//        rd.close();
        conn.disconnect();
        //System.out.println(sb.toString());

        parsingUrl = url.toString();
        System.out.println(parsingUrl);

        // 페이지에 접근할 Document 객체 생성, 파싱할 url 요소 읽기
        // doc.getDocumentElement().getNodeName() -> xml의 최상위 태그를 가져옴
        DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder docBuilder = dbFactory.newDocumentBuilder();
        Document doc = docBuilder.parse(parsingUrl);

        // root tag
        doc.getDocumentElement().normalize();
        //System.out.println("Root element: " + doc.getDocumentElement().getNodeName()); // Root element: result

        NodeList nodeList = doc.getElementsByTagName("item");   // 태그명 item
        System.out.println("number of parsing items : " + nodeList.getLength());

        try {
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
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
