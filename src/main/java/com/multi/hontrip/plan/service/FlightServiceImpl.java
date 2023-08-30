package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.FlightDAO;
import com.multi.hontrip.plan.dto.FlightDTO;
import com.multi.hontrip.plan.dto.FlightSearchDTO;
import com.multi.hontrip.plan.parser.FlightParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
public class FlightServiceImpl implements FlightService {
    private FlightDAO flightDAO;
    private FlightParser flightParser;
    @Autowired
    public FlightServiceImpl(FlightDAO flightDAO, FlightParser flightParser){
        this.flightDAO = flightDAO;
        this.flightParser = flightParser;
    }

    // 항공편 추가
    @Override
    public void insertFlight(FlightDTO flightDTO) {
        flightDAO.insert(flightDTO);
    }

    // 항공편 단일 조회
    @Override
    public FlightDTO findFlight(Long FlightId){
        return flightDAO.one(FlightId);
    }


    // 검색 항공편 수 카운트
    @Override
    public int countFlight(FlightSearchDTO flightSearchDTO) throws ParseException {
        // flightSearchDTO : 출발 공항명, 도착 공항명, 출발일
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String departure_date = format.format(flightSearchDTO.getDepDate());
        Date depDate = format.parse(departure_date);
        return flightDAO.count(flightSearchDTO.getDepAirportName(), flightSearchDTO.getArrAirportName(), depDate);
    }

    // 항공편 api 조회 및 데이터 파싱
    @Override
    public void parseData(FlightSearchDTO flightSearchDTO) throws IOException, ParserConfigurationException, SAXException, ParseException {
        List<FlightDTO> flightList = listFlight(flightSearchDTO);
        if (flightList.isEmpty() || flightList.size() == 0){

            List<FlightDTO> list = flightParser.parseData(flightSearchDTO.getDepAirportName(), flightSearchDTO.getArrAirportName(), flightSearchDTO.getDepDate());
            // DB에 데이터 추가
            for (FlightDTO flightDTO : list) {
                insertFlight(flightDTO);
            }
        }
    }

    // 항공편 목록 조회 - 일정 상세 (무한 스크롤 미적용)
    @Override
    public List<FlightDTO> listFlight(FlightSearchDTO flightSearchDTO) throws ParseException {
        // flightSearchDTO : 출발 공항명, 도착 공항명, 출발일
        // 들어올 때 yyyyMMdd 형식의 Date
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String departure_date = format.format(flightSearchDTO.getDepDate()); // yyyy-MM-dd 형식의 String으로 변환
        Date depDate = format.parse(departure_date); // 다시 date로 변환
        // DAO에 출발 공항명, 도착 공항명, 출발일, 시작 row num, 읽어올 row 수 전달
        return flightDAO.list(flightSearchDTO.getDepAirportName(), flightSearchDTO.getArrAirportName(), depDate);
    }

    // 항공편 목록 조회 - 일반 (무한 스크롤 적용)
    @Override
    public List<FlightDTO> listFlightWithScroll(FlightSearchDTO flightSearchDTO) throws ParseException {
        // flightSearchDTO : 출발 공항명, 도착 공항명, 출발일
        // 들어올 때 yyyyMMdd 형식의 Date
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String departure_date = format.format(flightSearchDTO.getDepDate()); // yyyy-MM-dd 형식의 String으로 변환
        Date depDate = format.parse(departure_date); // 다시 date로 변환
        // DAO에 출발 공항명, 도착 공항명, 출발일, 시작 row num, 읽어올 row 수 전달
        return flightDAO.listWithScroll(flightSearchDTO.getDepAirportName(), flightSearchDTO.getArrAirportName(), depDate,
                flightSearchDTO.getStartRowNum(), flightSearchDTO.getRowCount());
    }
    
    // 무한 스크롤 시 목록 조회
    @Override
    public List<FlightDTO> loadList(FlightSearchDTO flightSearchDTO) throws ParseException {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String departure_date = format.format(flightSearchDTO.getDepDate());
        Date depDate = format.parse(departure_date);
        // DAO에 출발 공항명, 도착 공항명, 출발일, 시작 row num, 읽어올 row 수 전달
        return flightDAO.listWithScroll(flightSearchDTO.getDepAirportName(), flightSearchDTO.getArrAirportName()
                , depDate, flightSearchDTO.getStartRowNum()
                , flightSearchDTO.getRowCount());
    }
}
