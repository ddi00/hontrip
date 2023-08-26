package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.SpotDAO;
import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.dto.SpotSearchDTO;
import com.multi.hontrip.plan.parser.SpotParser;
import com.mysql.cj.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class SpotServiceImpl implements SpotService {
    private SpotDAO spotDAO;
    private SpotParser spotParser;

    @Autowired
    public SpotServiceImpl(SpotDAO spotDAO, SpotParser spotParser) {
        this.spotDAO = spotDAO;
        this.spotParser = spotParser;
    }

    // 여행지 추가
    @Override
    public void insert(SpotDTO spotDTO) throws IOException, ParserConfigurationException, SAXException {
        spotDAO.insert(spotDTO);
    }

    // 여행지 세부 사항 추가
    @Override
    public SpotDTO updateDetails(SpotDTO spotDTO) throws IOException, ParserConfigurationException, SAXException {
        SpotDTO spot = new SpotDTO();   // 빈 SpotDTO 생성
        try {
            // 홈페이지, 개요 정보 없을 시 api 호출 및 조회 
            if (StringUtils.isNullOrEmpty(spotDTO.getHomepage()) || StringUtils.isNullOrEmpty(spotDTO.getOverview())) {
                spot = spotParser.parseCommonDetails(spotDTO);
            }
        } catch (NullPointerException e) { // NullPointerException 발생 시 빈 string 삽입 후 재호출
            spotDTO.setHomepage("");
            spotDTO.setOverview("");
            spotDTO = spotParser.parseCommonDetails(spotDTO);
        }
        // 문의 및 안내, 개장일, 휴일, 체험 안내, 이용 시간, 주차 시설 정보 없을 시 api 호출 및 조회
        try {
            if (StringUtils.isNullOrEmpty(spotDTO.getInfoCenter()) || StringUtils.isNullOrEmpty(spotDTO.getOpenDate())
                    || StringUtils.isNullOrEmpty(spotDTO.getRestDate()) || StringUtils.isNullOrEmpty(spotDTO.getExpguide())
                    || StringUtils.isNullOrEmpty(spotDTO.getUsetime()) || StringUtils.isNullOrEmpty(spotDTO.getParking())) {
                spotDTO = spotParser.parseIntroDetails(spotDTO);
            }
        } catch (NullPointerException e) {  // NullPointerException 발생 시 빈 string 삽입 후 재호출
            spotDTO.setInfoCenter("");
            spotDTO.setOpenDate("");
            spotDTO.setRestDate("");
            spotDTO.setExpguide("");
            spotDTO.setUsetime("");
            spotDTO.setParking("");
            spotDTO = spotParser.parseIntroDetails(spotDTO);
        }
        spotDAO.update(spotDTO);    // 데이터 수정
        return spotDTO;
    }

    // 검색 키워드로 조회 및 데이터 파싱
    @Override
    public void parseData(SpotSearchDTO spotSearchDTO) throws IOException, ParserConfigurationException, SAXException {
        //List<SpotDTO> spotList = list(spotSearchDTO); // 검색 대상 데이터 목록 조회

        // 검색 범주에 따라 분기
        if (spotSearchDTO.getCategory().equals("keyword")) {
            List<SpotDTO> list = spotParser.parseDataWithKeyword(spotSearchDTO.getKeyword());
            // DB에 데이터 추가
            for (SpotDTO spotDTO : list) {
                spotDAO.insert(spotDTO);
            }
//            미리 DB에 데이터 유무 조회하는 경우 겹치는 데이터가 하나라도 있을 경우 api 조회 안 하는 상황 발생하여 보류
//            if(spotList.isEmpty()) { // 없을 시 api 호출 및 조회
//                List<SpotDTO> list = spotParser.parseDataWithKeyword(spotSearchDTO.getKeyword());
//                // DB에 데이터 추가
//                for (SpotDTO spotDTO : list) {
//                    spotDAO.insert(spotDTO);
//                }
//            }
        } else if (spotSearchDTO.getCategory().equals("area")) {
            List<SpotDTO> list = spotParser.parseDataWithAreaName(spotSearchDTO.getKeyword());
            // DB에 데이터 추가
            for (SpotDTO spotDTO : list) {
                spotDAO.insert(spotDTO);
            }
//            미리 DB에 데이터 유무 조회하는 경우 겹치는 데이터가 하나라도 있을 경우 api 조회 안 하는 상황 발생하여 보류
//            if(spotList.isEmpty()) {    // 없을 시 api 호출 및 조회
//                List<SpotDTO> list = spotParser.parseDataWithAreaName(spotSearchDTO.getAreaName());
//                // DB에 데이터 추가
//                for (SpotDTO spotDTO : list) {
//                    spotDAO.insert(spotDTO);
//                }
//            }
        }
    }

    // 여행지 검색
    public List<SpotDTO> searchSpots(SpotSearchDTO spotSearchDTO) throws IOException, ParserConfigurationException, SAXException {
        List<SpotDTO> spotList = new ArrayList<>();
        // 사용자 검색 범주에 따라 키워드 검색 / 지역 검색으로 분기
        if (spotSearchDTO.getCategory().equals("keyword")){
            parseData(spotSearchDTO); // api 호출하여 키워드로 여행지 조회
            spotList = list(spotSearchDTO); // DB에서 조건에 맞는 데이터 select

        }else if (spotSearchDTO.getCategory().equals("area")){
            parseData(spotSearchDTO); // api 호출하여 지역명으로 여행지 조회
            spotList = list(spotSearchDTO); // DB에서 조건에 맞는 데이터 select
        }
        return spotList;
    }

    // 여행지 단일 조회
    @Override
    public SpotDTO findSpot(String contentId) {
        return spotDAO.one(contentId); // 여행지 콘텐츠 id로 조회 (※ 여행지 id 아님)
    }

    // 여행지 목록 조회
    @Override
    public List<SpotDTO> list(SpotSearchDTO spotSearchDTO) {
        String keyword = spotSearchDTO.getKeyword();
        if (spotSearchDTO.getCategory().equals("keyword")) {
            return spotDAO.listWithKeyword(keyword);
        } else if (spotSearchDTO.getCategory().equals("area")) {
            return spotDAO.listWithAreaName(keyword);
        }
        return null;
    }

    // 여행지 조회 결과 카운트
    @Override
    public int countSpot(String keyword) {
        return spotDAO.count(keyword);
    }
}
