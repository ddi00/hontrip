package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.FlightDAO;
import com.multi.hontrip.plan.dto.FlightDTO;
import com.multi.hontrip.plan.dto.FlightSearchDTO;
import com.multi.hontrip.plan.parser.Airport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.Date;
import java.util.List;

@Service
public class FlightService {

    @Autowired
    FlightDAO flightDAO;

    public void insert(FlightDTO dto) throws IOException, ParserConfigurationException, SAXException {
        flightDAO.insert(dto);
    }

    public List<FlightDTO> list(FlightSearchDTO flightSearchDTO) {
        // flightSearchDTO : 출발 공항명, 도착 공항명, 출발일
        // DTO - Airport enum 일치하는 공항명 리턴
        Airport depAirport = Airport.valueOf(flightSearchDTO.getDepAirportName());
        Airport arrAirport = Airport.valueOf(flightSearchDTO.getArrAirportName());
        Date depDate = flightSearchDTO.getDepDate();
        // DAO에 파라미터 넘김
        return flightDAO.list(depAirport.getAirportName(), arrAirport.getAirportName(), depDate);
    }
}
