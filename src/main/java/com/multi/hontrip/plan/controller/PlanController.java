package com.multi.hontrip.plan.controller;

import com.multi.hontrip.common.RequiredSessionCheck;
import com.multi.hontrip.plan.dto.*;
import com.multi.hontrip.plan.parser.Airport;
import com.multi.hontrip.plan.service.AccommodationService;
import com.multi.hontrip.plan.service.FlightService;
import com.multi.hontrip.plan.service.PlanService;
import com.multi.hontrip.plan.service.SpotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.xml.sax.SAXException;

import javax.servlet.http.HttpSession;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/plan")
public class PlanController {
    private final PlanService planService;
    private final SpotService spotService;
    private final FlightService flightService;

    private final AccommodationService accommodationService;

    @Autowired
    public PlanController(PlanService planService, SpotService spotService, FlightService flightService, AccommodationService accommodationService) {
        this.planService = planService;
        this.spotService = spotService;
        this.flightService = flightService;
        this.accommodationService = accommodationService;
    }

    // 일정 생성
    @RequestMapping("/create")
    @RequiredSessionCheck
    public String showPlanForm(@ModelAttribute("planDTO") PlanDTO planDTO, HttpSession session) {
        session.getAttribute("id");
        return "/plan/create"; // 일정 생성 폼 반환
    }

    @PostMapping("/insert") // plan_form에서 작성한 내용 insert
    public String insert(@ModelAttribute("planDTO") PlanDTO planDTO, HttpSession session, RedirectAttributes redirectAttributes) {
        Long userId = (Long) session.getAttribute("id");
        planDTO.setUserId(userId);
        long insertedPlanId = planService.insertPlan(planDTO);
        // 리다이렉트할 파라미터 전달
        redirectAttributes.addAttribute("userId", userId);
        redirectAttributes.addAttribute("planId", insertedPlanId);

//        return "redirect:/plan/list"; // 일정 생성 후 일정 목록으로 리다이렉트
        return "redirect:/plan/edit";
    }


    // 일정 수정 - 여행지, 항공권, 숙소 추가
    @GetMapping("/edit")
    @RequiredSessionCheck
    public String updateDetail(@RequestParam("userId") Long userId,
                               @RequestParam("planId") Long planId,
                               @ModelAttribute("planDTO") PlanDTO planDTO,
                               Model model, HttpSession session) {
        session.getAttribute("id");
        PlanDTO plan = planService.findPlan(planId, userId); // 단일 일정 조회
        // 일차 계산
        int numOfDays = planService.calculateDays(plan.getStartDate(), plan.getEndDate());
        // 기존에 추가되어 있던 여행지 담을 리스트
        List<SpotLoadDTO> addedSpots = planService.loadExistingSpots(plan, numOfDays);
        // 기존에 추가되어 있던 항공권 담을 리스트
        List<FlightLoadDTO> addedFlights = planService.loadExistingFlights(plan);

        // plan_day 에 저장된 accommodation(숙박지)리스트를 담을 변수 - 1일차만 구하므로 numOfDays 는 필요없음
        List<AccommodationLoadDTO> addedAccommodations
                = planService.loadExistingAccommodations(plan);
        /*System.out.println("addedAccommodations : " + addedAccommodations);*/

        model.addAttribute("addedSpots", addedSpots);
        model.addAttribute("addedFlights", addedFlights);
        model.addAttribute("numOfDays", numOfDays);
        model.addAttribute("plan", plan);
        model.addAttribute("addedAccommodations", addedAccommodations);
        return "/plan/edit"; // 일정 수정 폼
    }

    // 일정 수정 - 기본 정보
    @PostMapping("/update")
    public String updatePlan(PlanDTO planDTO) {
        planService.updatePlan(planDTO);
        return "redirect:/plan/edit?" + "userId=" + planDTO.getUserId() + "&planId=" + planDTO.getPlanId();
    }

    // 일정 수정 - 여행지 조회
    @RequestMapping("/detail/search-spot")
    public String searchSpot(@RequestParam("userId") Long userId,
                             @RequestParam("planId") Long planId,
                             @RequestParam("dayOrder") int dayOrder,
                             @RequestParam("category") String category,
                             @RequestParam("keyword") String keyword, Model model)
            throws ParserConfigurationException, SAXException, IOException {

        SpotSearchDTO spotSearchDTO = new SpotSearchDTO();
        spotSearchDTO.setCategory(category);
        spotSearchDTO.setKeyword(keyword);

        List<SpotDTO> spotList = spotService.searchSpots(spotSearchDTO); // 여행지 검색
        if (spotList.isEmpty()) {
            model.addAttribute("message", "검색 결과가 없습니다."); // 검색 데이터 없는 경우 메시지 표시
        } else {
            model.addAttribute("list", spotList);
        }

        model.addAttribute("category", spotSearchDTO.getCategory());
        model.addAttribute("keyword", spotSearchDTO.getKeyword());
        model.addAttribute("dayOrder", dayOrder);

        return "/plan/spot/search_list_for_plan";
    }

    // 일정 수정 - 조회한 여행지 목록에서 여행지 추가
    @RequestMapping("/detail/update-plan-spot")
    @ResponseBody
    public SpotAddDTO updateSpot(@RequestParam("userId") Long userId,
                                 @RequestParam("planId") Long planId,
                                 @RequestParam("dayOrder") int dayOrder,
                                 @RequestParam("spotContentId") String spotContentId) {
        // plan-day에 여행지 정보 추가
        planService.addSpotToDay(planId, userId, dayOrder, spotContentId);

        // 추가 완료된 spotAddDTO 반환
        return planService.createSpotAddDTO(planId, spotContentId);
    }

    // 일정 수정 - 추가한 여행지 목록에서 여행지 삭제
    @RequestMapping("/detail/delete-plan-spot")
    @ResponseBody
    @RequiredSessionCheck
    public ResponseEntity<String> deleteSpot(@RequestParam("userId") Long userId,
                                             @RequestParam("planId") Long planId,
                                             @RequestParam("dayOrder") int dayOrder,
                                             @RequestParam("spotOrder") int spotOrder,
                                             @RequestParam("spotContentId") String spotContentId, HttpSession session) {

        Long sessionUserId = (Long) session.getAttribute("id");

        try {
            // plan-day에서 여행지 정보 삭제
            planService.deleteSpotFromDay(planId, sessionUserId, dayOrder, spotOrder, spotContentId);
            return ResponseEntity.ok("삭제 성공");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }

    // 일정 수정 - 항공권 조회
    @RequestMapping("/detail/search-flight")
    public String searchFlight(@RequestParam("userId") Long userId,
                               @RequestParam("planId") Long planId,
                               @RequestParam("depAirportName") String depAirportName,
                               @RequestParam("arrAirportName") String arrAirportName,
                               @RequestParam("depDate") String depDate, Model model)
            throws ParserConfigurationException, SAXException, IOException, ParseException {

        FlightSearchDTO flightSearchDTO = new FlightSearchDTO();

        // Airport enum
        Airport departure_airport = Airport.valueOf(depAirportName);
        Airport arrival_airport = Airport.valueOf(arrAirportName);

        String departure_airport_name = departure_airport.getAirportName();
        String arrival_airport_name = arrival_airport.getAirportName();

        flightSearchDTO.setDepAirportName(departure_airport_name);
        flightSearchDTO.setArrAirportName(arrival_airport_name);

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date departure_date = formatter.parse(depDate);
        flightSearchDTO.setDepDate(departure_date);

        flightService.parseData(flightSearchDTO);
        List<FlightDTO> FlightList = flightService.listFlight(flightSearchDTO);

        model.addAttribute("depAirportName", departure_airport_name);
        model.addAttribute("arrAirportName", arrival_airport_name);
        model.addAttribute("depDate", depDate);

        if(FlightList.isEmpty()){
            model.addAttribute("message", "검색 결과가 없습니다."); // 검색 데이터 없는 경우 메시지 표시
        } else {
            model.addAttribute("list", FlightList);
        }

        return "/plan/flight/search_list_for_plan";
    }

    // 일정 수정 - 조회한 항공권 목록에서 항공권 추가
    @RequestMapping("/detail/update-plan-flight")
    @ResponseBody
    public FlightAddDTO updateSpot(@RequestParam("userId") Long userId,
                                @RequestParam("planId") Long planId,
                                @RequestParam("flightId") Long flightId) {
        // plan-day에 항공권 정보 추가
        planService.addFlightToDay(planId, userId, flightId);

        // 추가 완료된 flightAddDTO 반환
        return planService.createFlightAddDTO(planId, flightId);
    }

    // 일정 수정 - 추가한 항공권 목록에서 항공권 삭제
    @RequestMapping("/detail/delete-plan-flight")
    @ResponseBody
    @RequiredSessionCheck
    public ResponseEntity<String> deleteFlight(@RequestParam("userId") Long userId,
                                             @RequestParam("planId") Long planId,
                                             @RequestParam("flightId") String flightId, HttpSession session) {

        Long sessionUserId = (Long) session.getAttribute("id");

        try {
            // plan-day에서 항공권 정보 삭제
            planService.deleteFlightFromDay(planId, sessionUserId, flightId);
            return ResponseEntity.ok("삭제 성공");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }

    @RequestMapping(value = "detail/search-accommodation")
    public String filterAccommodationList(
            @RequestParam(name = "addressName", required = false) String addressName,
            @RequestParam(name = "placeName", required = false) String placeName,
            @RequestParam(name = "categoryName", required = false) String categoryName,
            @RequestParam(name = "filterType", required = false) String filterType,
            Model model
    ) {

        List<AccommodationDTO> list = null;


        if ("address_place".equals(filterType)  ) {
            list = accommodationService.filterByAddressAndPlaceName(addressName, placeName);
        } else if ("address".equals(filterType)  ) {
            list = accommodationService.filterByAddress(addressName);
        } else if ("place_name".equals(filterType) && !"".equals(placeName) ) {
            list = accommodationService.filterByPlaceName(placeName);
        }  else {
            list = accommodationService.list();
        }

        if(list.isEmpty()){
            model.addAttribute("message", "검색 결과가 없습니다."); // 검색 데이터 없는 경우 메시지 표시
        } else {
            model.addAttribute("list", list);
        }


        return "/plan/accommodation/accommodation_search_list_for_plan";
        //return "/plan/accommodation/filter_list";
        //return "/plan/accommodation/list";
    }

    // 숙박지 추가 - 채림
    @RequestMapping("/detail/update-plan-accommodation")
    @ResponseBody
    public AccommodationAddDTO updateAccommodation(@RequestParam("planId") Long planId,
                                                   @RequestParam("userId") Long userId,
                                                   //@RequestParam("dayOrder") int dayOrder,
                                                   @RequestParam("accommodationId") String accommodationId, Model model) {
        // plan-day에 여행지 정보 추가

        /*System.out.println("start adding accommodationToDay accommodationId ---- : " + accommodationId);*/

        //plan-day 에 숙박지 정보 추가
        //planService.addAccommodationToDay(planId, userId, 1, accommodationId);
        //planService.addAccommodation(planService.addAccommodationToDay(planId, userId, 1, accommodationId));

        //plan-day 에 숙박지 정보 추가
        PlanDayDTO dayPlanDto
                = planService.addAccommodationToDay(planId, userId, 1, Long.parseLong(accommodationId));

        //model.addAttribute("planId", planId);
        // 추가 완료된 accommodationDTO 변환
        return planService.createAccommodationAddDTO(planId, accommodationId);
    }


    // 채림 - 추가한 숙박지 삭제
    @RequestMapping("/detail/delete-plan-accommodation")
    @ResponseBody
    @RequiredSessionCheck
    public ResponseEntity<String> deleteAccommodation(@RequestParam("userId") Long userId,
                                                      @RequestParam("planId") Long planId,
                                                      @RequestParam("accommodationId") String accommodationId, HttpSession session) {

        Long sessionUserId = (Long) session.getAttribute("id");

        try {
            // plan-day 테이블에서 숙박지 정보 삭제
            planService.deleteFlightFromDay(planId, sessionUserId, accommodationId);
            planService.deleteAccommodationFromDay(planId, sessionUserId, accommodationId);
            return ResponseEntity.ok("삭제 성공");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }


    // 일정 삭제
    @RequestMapping("/delete")
    @RequiredSessionCheck
    public ResponseEntity<String> delete(@RequestParam("userId") Long userId,
                         @RequestParam("planId") Long planId, HttpSession session) {
        Long sessionUserId = (Long) session.getAttribute("id");
        try {
            planService.deletePlan(planId, sessionUserId);
            return ResponseEntity.ok("삭제 성공");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 실패");
        }
    }

    // 일정 목록 보기
    @RequestMapping("/list")
    @RequiredSessionCheck
    public String list(Model model, HttpSession session) {
        Long userId = (Long) session.getAttribute("id");
        List<PlanDTO> list = planService.findPlanList(userId);

        List<Integer> numOfDays = new ArrayList<>();
        for (PlanDTO plan : list) {
            int days = planService.calculateDays(plan.getStartDate(), plan.getEndDate());
            numOfDays.add(days);
        }
        model.addAttribute("numOfDays", numOfDays);
        model.addAttribute("list", list);
        return "/plan/list";
    }
}