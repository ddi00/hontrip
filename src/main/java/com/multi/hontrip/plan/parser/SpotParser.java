package com.multi.hontrip.plan.parser;

import com.multi.hontrip.plan.dto.SpotDTO;
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
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

@Component
@PropertySource("classpath:properties/plan/openApi.properties")
public class SpotParser {
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

    // 사용자 입력 지역명 - 지역코드 맵핑하기 위한 메소드
    public static String getAreaCodeByAreaName(String areaName) {
        String areaCode = "";
        for (Area area : Area.values()) {
            if (area.getAreaName().contains(areaName)) {
                areaCode = area.getAreaCode();
            }
        }
        return areaCode;
    }

    // 여행지 api 호출 및 데이터 파싱
    // 지역 기반 관광 정보 조회
    public List<SpotDTO> parseDataWithAreaName(String areaName) throws IOException, ParserConfigurationException, SAXException {
        List<SpotDTO> list = new ArrayList<>();
        String parsingUrl = "";

        int pageNo = 1;
        String areaCode = getAreaCodeByAreaName(areaName);

        try {
            while (true) {
                // 지역 기반 관광 정보 조회
                StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/KorService1/areaBasedList1"); // URL
                urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + SERVICE_KEY); // Service Key
                urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(String.valueOf(pageNo), "UTF-8")); // 페이지번호
                urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); // 한 페이지 결과 수
                urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); // OS 구분 : IOS (아이폰), AND (안드로이드), WIN (윈도우폰), ETC(기타)
                urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); // 서비스명(어플명)
                urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); // 응답메세지 형식
                urlBuilder.append("&" + URLEncoder.encode("listYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); // 목록구분(Y=목록, N=개수)
                urlBuilder.append("&" + URLEncoder.encode("arrange", "UTF-8") + "=" + URLEncoder.encode("A", "UTF-8")); // 정렬구분 (A=제목순, C=수정일순, D=생성일순) 대표이미지가반드시있는정렬(O=제목순, Q=수정일순, R=생성일순)
                urlBuilder.append("&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode("12", "UTF-8")); // 관광타입(12:관광지, 14:문화시설, 15:축제공연행사, 25:여행코스, 28:레포츠, 32:숙박, 38:쇼핑, 39:음식점) ID
                urlBuilder.append("&" + URLEncoder.encode("areaCode", "UTF-8") + "=" + URLEncoder.encode(areaCode, "UTF-8")); // 지역코드
                // urlBuilder.append("&" + URLEncoder.encode("sigunguCode", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); // 시군구코드 - 미지정시 지정 지역 전체 대상

                URL url = new URL(urlBuilder.toString());
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.setRequestProperty("Content-type", "application/json");
                //System.out.println("Response code: " + conn.getResponseCode());
                conn.disconnect();

                parsingUrl = url.toString();
                //System.out.println(parsingUrl);

                // 페이지에 접근할 Document 객체 생성, 파싱할 url 요소 읽기
                DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
                DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
                Document doc = dBuilder.parse(parsingUrl);

                // root tag
                doc.getDocumentElement().normalize(); // xml 루트 요소 정규화
                NodeList nodeList = doc.getElementsByTagName("item");   // 태그명 item
                //System.out.println("the number of parsing items : " + nodeList.getLength());

                // 파싱 대상 수만큼 for문 반복
                for (int i = 0; i < nodeList.getLength(); i++) {
                    Node node = nodeList.item(i);
                    if (node.getNodeType() == Node.ELEMENT_NODE) { // 노드 타입 element 여부 확인
                        Element element = (Element) node;
                        SpotDTO spotDTO = new SpotDTO();
                        // tag value 읽어와 dto에 set
                        spotDTO.setContentId(getTagValue("contentid", element)); // contentId
                        spotDTO.setContentTypeId(getTagValue("contenttypeid", element)); // contentTypeId
                        spotDTO.setTitle(getTagValue("title", element)); // title
                        // tel
                        try {
                            spotDTO.setTel(getTagValue("tel", element));
                        } catch (NullPointerException e) {
                            spotDTO.setTel("");
                        }
                        // image
                        try {
                            if (getTagValue("firstimage", element) == null) {
                                spotDTO.setImage("https://via.placeholder.com/550x450.png?text=No%20image"); // 이미지 데이터 없을 시 빈 이미지 삽입
                            } else {
                                spotDTO.setImage(getTagValue("firstimage", element));
                            }
                        } catch (NullPointerException e) {
                            spotDTO.setImage("https://via.placeholder.com/550x450.png?text=No%20image");
                        }
                        // hompage
                        try {
                            spotDTO.setHomepage(getTagValue("hompage", element));
                        } catch (NullPointerException e) {
                            spotDTO.setHomepage("");
                        }
                        // address
                        try {
                            if (getTagValue("addr2", element) == null) {
                                spotDTO.setAddress(getTagValue("addr1", element));
                            } else {
                                spotDTO.setAddress(getTagValue("addr1", element) + " " + getTagValue("addr2", element));
                            }
                        } catch (NullPointerException e) {
                            try {
                                spotDTO.setAddress(getTagValue("addr1", element));
                            } catch (NullPointerException ex) {
                                spotDTO.setAddress("주소 미제공");
                            }
                        }
                        spotDTO.setMapX(getTagValue("mapx", element));  // mapX
                        spotDTO.setMapY(getTagValue("mapy", element));  // mapY
                        spotDTO.setAreaCode(getTagValue("areacode", element));  // areaCode
                        spotDTO.setSigunguCode(getTagValue("sigungucode", element));    // sigunguCode
                        list.add(spotDTO);
                    }
                }
                pageNo += 1;
                if (pageNo > 7) { // 7 페이지 넘어가면 while문 break
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 	키워드 검색 조회
    public List<SpotDTO> parseDataWithKeyword(String keyword) throws IOException, ParserConfigurationException, SAXException {
        List<SpotDTO> list = new ArrayList<>();
        String parsingUrl = "";
        String decodedKeyword = URLDecoder.decode(keyword, "UTF-8"); // 이중 인코딩 방지 디코딩

        try {
            StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/KorService1/searchKeyword1"); // URL
            urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + SERVICE_KEY); // Service Key
            urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); // 페이지번호
            urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("200", "UTF-8")); // 한 페이지 결과 수
            urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); // OS 구분 : IOS (아이폰), AND (안드로이드), WIN (윈도우폰), ETC(기타)
            urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); // 서비스명(어플명)
            urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); // 응답메세지 형식
            urlBuilder.append("&" + URLEncoder.encode("listYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); // 목록구분(Y=목록, N=개수)
            urlBuilder.append("&" + URLEncoder.encode("arrange", "UTF-8") + "=" + URLEncoder.encode("A", "UTF-8")); // 정렬구분 (A=제목순, C=수정일순, D=생성일순) 대표이미지가반드시있는정렬(O=제목순, Q=수정일순, R=생성일순)
            urlBuilder.append("&" + URLEncoder.encode("keyword", "UTF-8") + "=" + URLEncoder.encode(decodedKeyword, "UTF-8")); // 여행지 검색 키워드
            urlBuilder.append("&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode("12", "UTF-8")); // 관광타입(12:관광지, 14:문화시설, 15:축제공연행사, 25:여행코스, 28:레포츠, 32:숙박, 38:쇼핑, 39:음식점) ID

            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            conn.disconnect();

            parsingUrl = url.toString();

            // 페이지에 접근할 Document 객체 생성, 파싱할 url 요소 읽기
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(parsingUrl);

            // root tag
            doc.getDocumentElement().normalize(); // xml 루트 요소 정규화
            NodeList nodeList = doc.getElementsByTagName("item");   // 태그명 item

            // 파싱 대상 수만큼 for문 반복
            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) { // 노드 타입 element 여부 확인
                    Element element = (Element) node;
                    SpotDTO spotDTO = new SpotDTO();
                    // tag value 읽어와 dto에 set
                    spotDTO.setContentId(getTagValue("contentid", element)); // contentId
                    spotDTO.setContentTypeId(getTagValue("contenttypeid", element)); // contentTypeId
                    spotDTO.setTitle(getTagValue("title", element)); // title
                    // tel
                    try {
                        spotDTO.setTel(getTagValue("tel", element));
                    } catch (NullPointerException e) {
                        spotDTO.setTel("");
                    }
                    // image
                    try {
                        if (getTagValue("firstimage", element) == null) {
                            spotDTO.setImage("https://via.placeholder.com/550x450.png?text=No%20image");
                        } else {
                            spotDTO.setImage(getTagValue("firstimage", element));
                        }
                    } catch (NullPointerException e) {
                        spotDTO.setImage("https://via.placeholder.com/550x450.png?text=No%20image");
                    }
                    // hompage
                    try {
                        spotDTO.setHomepage(getTagValue("hompage", element));
                    } catch (NullPointerException e) {
                        spotDTO.setHomepage("");
                    }
                    // address
                    try {
                        if (getTagValue("addr2", element) == null) {
                            spotDTO.setAddress(getTagValue("addr1", element));
                        } else {
                            spotDTO.setAddress(getTagValue("addr1", element) + " " + getTagValue("addr2", element));
                        }
                    } catch (NullPointerException e) {
                        try {
                            spotDTO.setAddress(getTagValue("addr1", element));
                        } catch (NullPointerException ex) {
                            spotDTO.setAddress("주소 미제공");
                        }
                    }
                    spotDTO.setMapX(getTagValue("mapx", element));  // mapX
                    spotDTO.setMapY(getTagValue("mapy", element));  // mapY
                    spotDTO.setAreaCode(getTagValue("areacode", element));  // areaCode
                    spotDTO.setSigunguCode(getTagValue("sigungucode", element));    // sigunguCode
                    list.add(spotDTO);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 공통 정보 조회 - 홈페이지, 개요
    public SpotDTO parseCommonDetails(SpotDTO spotDTO) throws IOException, ParserConfigurationException, SAXException {
        String parsingUrl = "";

        try {
            StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/KorService1/detailCommon1"); // URL
            urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + SERVICE_KEY); // Service Key
            urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); // OS 구분 : IOS (아이폰), AND (안드로이드), WIN (윈도우폰), ETC(기타)
            urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); // 서비스명(어플명)
            urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); // 응답메세지 형식
            urlBuilder.append("&" + URLEncoder.encode("contentId", "UTF-8") + "=" + URLEncoder.encode(spotDTO.getContentId(), "UTF-8")); // 콘텐츠ID
            urlBuilder.append("&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode("12", "UTF-8")); // 관광타입(12:관광지, 14:문화시설, 15:축제공연행사, 25:여행코스, 28:레포츠, 32:숙박, 38:쇼핑, 39:음식점) ID
            urlBuilder.append("&" + URLEncoder.encode("defaultYN", "UTF-8") + "=" + URLEncoder.encode("N", "UTF-8")); // 기본정보조회여부( Y,N )
            urlBuilder.append("&" + URLEncoder.encode("firstImageYN", "UTF-8") + "=" + URLEncoder.encode("N", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("areacodeYN", "UTF-8") + "=" + URLEncoder.encode("N", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("addrinfoYN", "UTF-8") + "=" + URLEncoder.encode("N", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("mapinfoYN", "UTF-8") + "=" + URLEncoder.encode("N", "UTF-8"));
            urlBuilder.append("&" + URLEncoder.encode("overviewYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); // 콘텐츠개요조회여부( Y,N )
            urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); // 한 페이지 결과 수
            urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); // 페이지번호

            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            conn.disconnect();

            parsingUrl = url.toString();

            // 페이지에 접근할 Document 객체 생성, 파싱할 url 요소 읽기
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(parsingUrl);

            // root tag
            doc.getDocumentElement().normalize();

            NodeList nodeList = doc.getElementsByTagName("item");   // 태그명 item

            Node node = nodeList.item(0);
            if (node.getNodeType() == Node.ELEMENT_NODE) { // 노드 타입 element 여부 확인
                Element element = (Element) node;
                // tag value 읽어와 dto에 set
                spotDTO.setContentId(getTagValue("contentid", element)); // contentId
                // hompage
                try {
                    spotDTO.setHomepage(getTagValue("hompage", element));
                } catch (NullPointerException e) {
                    spotDTO.setHomepage("");
                }
                // overview
                try {
                    spotDTO.setOverview(getTagValue("overview", element));
                } catch (NullPointerException e) {
                    spotDTO.setOverview("");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return spotDTO;
    }

    // 소개 정보 조회 - 문의 및 안내, 개장일, 휴일, 체험 안내, 이용 시간, 주차 시설
    public SpotDTO parseIntroDetails(SpotDTO spotDTO) throws IOException, ParserConfigurationException, SAXException {
        String parsingUrl = "";

        try {
            StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/B551011/KorService1/detailIntro1"); // URL
            urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + SERVICE_KEY); // Service Key
            urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); // OS 구분 : IOS (아이폰), AND (안드로이드), WIN (윈도우폰), ETC(기타)
            urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); // 서비스명(어플명)
            urlBuilder.append("&" + URLEncoder.encode("_type", "UTF-8") + "=" + URLEncoder.encode("xml", "UTF-8")); // 응답메세지 형식
            urlBuilder.append("&" + URLEncoder.encode("contentId", "UTF-8") + "=" + URLEncoder.encode(spotDTO.getContentId(), "UTF-8")); // 콘텐츠ID
            urlBuilder.append("&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode("12", "UTF-8")); // 관광타입(12:관광지, 14:문화시설, 15:축제공연행사, 25:여행코스, 28:레포츠, 32:숙박, 38:쇼핑, 39:음식점) ID
            urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); // 한 페이지 결과 수
            urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); // 페이지번호

            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            conn.disconnect();

            parsingUrl = url.toString();

            // 페이지에 접근할 Document 객체 생성, 파싱할 url 요소 읽기
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(parsingUrl);

            // root tag
            doc.getDocumentElement().normalize();

            NodeList nodeList = doc.getElementsByTagName("item");   // 태그명 item

            Node node = nodeList.item(0);
            if (node.getNodeType() == Node.ELEMENT_NODE) { // 노드 타입 element 여부 확인
                Element element = (Element) node;
                // tag value 읽어와 dto에 set
                spotDTO.setContentId(getTagValue("contentid", element)); // contentId

                // infoCenter
                try {
                    spotDTO.setInfoCenter(getTagValue("infocenter", element));
                } catch (NullPointerException e) {
                    spotDTO.setInfoCenter("");
                }
                // openDate
                try {
                    spotDTO.setOpenDate(getTagValue("opendate", element));
                } catch (NullPointerException e) {
                    spotDTO.setOpenDate("");
                }
                // restDate
                try {
                    spotDTO.setRestDate(getTagValue("restdate", element));
                } catch (NullPointerException e) {
                    spotDTO.setRestDate("");
                }
                // expguide
                try {
                    spotDTO.setExpguide(getTagValue("expguide", element));
                } catch (NullPointerException e) {
                    spotDTO.setExpguide("");
                }
                // usetime
                try {
                    spotDTO.setUsetime(getTagValue("usetime", element));
                } catch (NullPointerException e) {
                    spotDTO.setUsetime("");
                }
                // parking
                try {
                    spotDTO.setParking(getTagValue("parking", element));
                } catch (NullPointerException e) {
                    spotDTO.setParking("");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return spotDTO;
    }
}