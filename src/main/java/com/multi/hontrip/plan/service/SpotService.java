package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.dto.SpotInfoDTO;
import com.multi.hontrip.plan.dto.SpotLikeDTO;
import com.multi.hontrip.plan.dto.SpotSearchDTO;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.List;

public interface SpotService {

    // 여행지 추가
    void insert(SpotDTO spotDTO) throws IOException, ParserConfigurationException, SAXException;

    // 여행지 세부 사항 존재 여부 확인
    int checkSpotDetails(String contentId);

    // 여행지 세부 사항 추가
    SpotDTO updateDetails(SpotDTO spotDTO) throws IOException, ParserConfigurationException, SAXException;

    // 여행지 키워드로 조회 및 데이터 파싱
    void parseData(SpotSearchDTO spotSearchDTO) throws IOException, ParserConfigurationException, SAXException;

    // 여행지 검색
    List<SpotDTO> searchSpots(SpotSearchDTO spotSearchDTO) throws IOException, ParserConfigurationException, SAXException;

    // 여행지 단일 조회
    SpotDTO findSpot(String contentId);

    // 여행지 목록 조회
    List<SpotDTO> list(SpotSearchDTO spotSearchDTO);

    // 여행지 조회 결과 카운트
    int countSpot(String keyword);

    // 즐겨찾기 수 상위 여행지 10개 조회
    List<SpotInfoDTO> listTopTenSpot();
}
