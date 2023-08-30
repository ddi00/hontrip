package com.multi.hontrip.plan.dto;

import lombok.Data;

@Data
public class FlightLoadDTO {

    private Long planId;    // 일정 아이디
    private Long userId;    // 사용자 id
    private Long id;    // 항공 id
    private String vehicleId;   // 항공편 id
    private String airlineName; // 항공사명
    private String depAirportName;  // 출발 공항명
    private String departureTime;   // 출발 시간
    private String arrAirportName;  // 도착 공항명
    private String arrivalTime; // 도착 시간

}
