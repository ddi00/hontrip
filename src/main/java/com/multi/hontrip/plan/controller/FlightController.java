package com.multi.hontrip.plan.controller;


import com.multi.hontrip.plan.dto.FlightSearchDTO;
import com.multi.hontrip.plan.parser.Airport;
import com.multi.hontrip.plan.service.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@Controller
@RequestMapping("plan/flight")
public class FlightController {

    private final FlightService flightService;
    @Autowired
    public FlightController(FlightService flightService) {
        this.flightService = flightService;
    }

    // 항공편 검색
    @GetMapping("search_form")
    public String showFlightSearchForm(@ModelAttribute("FlightSearchDTO") FlightSearchDTO flightSearchDTO) {
        return "/plan/flight/search_form"; // 항공편 검색 폼 반환
    }

    // 항공편 검색 목록
    @PostMapping("search")
    public String SearchFlight(@ModelAttribute("FlightSearchDTO") FlightSearchDTO flightSearchDTO, Model model)
            throws ParserConfigurationException, SAXException, IOException{
        flightService.parseData(flightSearchDTO);

        SimpleDateFormat format = new SimpleDateFormat("yyyy년 MM월 dd일");
        String departure_date = format.format(flightSearchDTO.getDepDate());
        // Airport enum
        Airport departure_airport = Airport.valueOf(flightSearchDTO.getDepAirportName());
        Airport arrival_airport = Airport.valueOf(flightSearchDTO.getArrAirportName());

        model.addAttribute("depAirportName", departure_airport.getAirportName());
        model.addAttribute("arrAirportName", arrival_airport.getAirportName());
        model.addAttribute("depDate", departure_date); // 출발일 yyyyMMdd 형식으로 formatting

        // DB에서 출발 공항, 도착 공항, 출발일 조건에 맞는 데이터 select
        model.addAttribute("list", flightService.list(flightSearchDTO));
        return "/plan/flight/search_list"; // 조건에 맞는 항공편 검색 목록 반환
    }

}
