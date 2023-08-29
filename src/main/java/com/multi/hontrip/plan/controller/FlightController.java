package com.multi.hontrip.plan.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.plan.dto.FlightDTO;
import com.multi.hontrip.plan.dto.FlightSearchDTO;
import com.multi.hontrip.plan.parser.Airport;
import com.multi.hontrip.plan.service.FlightService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/plan/flight")
public class FlightController {

    private final FlightService flightService;
    @Autowired
    public FlightController(FlightService flightService) {
        this.flightService = flightService;
    }

    // 항공편 검색
    @GetMapping("/search")
    public String showFlightSearchForm(@ModelAttribute("FlightSearchDTO") FlightSearchDTO flightSearchDTO) {
        return "/plan/flight/search_form"; // 항공편 검색 폼 반환
    }

    // 항공편 검색 목록
    @PostMapping("/search-flight")
    public String SearchFlight(@ModelAttribute("FlightSearchDTO") FlightSearchDTO flightSearchDTO, Model model)
            throws ParserConfigurationException, SAXException, IOException, ParseException {
        final int PAGE_ROW_COUNT = 10; // 한 페이지에 표시할 항공편 개수
        int pageNum = 1; // 페이지 번호
        int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT; // 시작 row 번호
        int endRowNum = pageNum * PAGE_ROW_COUNT; // 마지막 row 번호
        int rowCount = PAGE_ROW_COUNT; // row 카운트

        // Airport enum
        Airport departure_airport = Airport.valueOf(flightSearchDTO.getDepAirportName());
        Airport arrival_airport = Airport.valueOf(flightSearchDTO.getArrAirportName());

        String departure_airport_name = departure_airport.getAirportName();
        String arrival_airport_name = arrival_airport.getAirportName();

        // KIMPO -> 김포
        flightSearchDTO.setDepAirportName(departure_airport_name);
        flightSearchDTO.setArrAirportName(arrival_airport_name);

        flightService.parseData(flightSearchDTO);

        // 뷰로 보내기 위함
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        String departure_date = format.format(flightSearchDTO.getDepDate());

        model.addAttribute("depAirportName", departure_airport_name);
        model.addAttribute("arrAirportName", arrival_airport_name);
        model.addAttribute("depDate", departure_date);

        flightSearchDTO.setStartRowNum(startRowNum);
        flightSearchDTO.setEndRowNum(endRowNum);
        flightSearchDTO.setRowCount(rowCount);

        // DB에서 출발 공항, 도착 공항, 출발일 조건에 맞는 데이터 select
        List<FlightDTO> FlightList = flightService.listFlightWithScroll(flightSearchDTO);

        // 검색 대상 항공편 수
        int totalRow = flightService.countFlight(flightSearchDTO);
        // 전체 페이지 수
        int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

        model.addAttribute("totalPageCount", totalPageCount);
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("pageNum", pageNum);
        if(FlightList.isEmpty()){
            model.addAttribute("message", "검색 결과가 없습니다."); // 검색 데이터 없는 경우 메시지 표시
        } else {
            model.addAttribute("list", FlightList);
        }

        return "/plan/flight/search_list"; // 조건에 맞는 항공편 검색 목록 반환
    }
    
    // 로딩으로 불러오는 목록
    @RequestMapping("/search-page")
    public String searchWithScrolling(@RequestParam int pageNum,
                                 @RequestParam String depAirportName,
                                 @RequestParam String arrAirportName,
                                 @RequestParam String depDate,
                                 Model model) throws ParseException {
        final int PAGE_ROW_COUNT = 10; // 한 페이지에 표시할 항공편 개수

        int startRowNum = 0 + (pageNum - 1) * PAGE_ROW_COUNT;
        int endRowNum = pageNum * PAGE_ROW_COUNT;
        int rowCount = PAGE_ROW_COUNT;

        FlightSearchDTO flightSearchDTO = new FlightSearchDTO();

        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd"); // Date 로 바꿀 String 의 형식
        Date departure_date = format.parse(depDate);
        flightSearchDTO.setDepDate(departure_date);

        flightSearchDTO.setDepAirportName(depAirportName);
        flightSearchDTO.setArrAirportName(arrAirportName);
        flightSearchDTO.setStartRowNum(startRowNum);
        flightSearchDTO.setEndRowNum(endRowNum);
        flightSearchDTO.setRowCount(rowCount);

        List<FlightDTO> list = flightService.loadList(flightSearchDTO);

        // 검색 대상 항공편 수
        int totalRow = flightService.countFlight(flightSearchDTO);
        // 전체 페이지 수
        int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);

        model.addAttribute("totalPageCount", totalPageCount);
        model.addAttribute("totalRow", totalRow);
        model.addAttribute("pageNum", pageNum);

        model.addAttribute("list", list);

        return "/plan/flight/search_list_page";
    }
}