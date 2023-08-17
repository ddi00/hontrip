package com.multi.hontrip.plan.dto;

import lombok.Data;

@Data
public class FlightDTO {

    private Long id;    // 항공 id
    private String vehicleId;   // 항공편 id
    private String airlineName; // 항공사명
    private String depAirportName;  // 출발 공항명
    private String departureTime;   // 출발 시간
    private String arrAirportName;  // 도착 공항명
    private String arrivalTime; // 도착 시간
    private int economyCharge;  // 이코노미석 운임
    private int prestigeCharge; // 프레스티지석 운임

    public void setEconomyCharge(String economyCharge) {    // economyCharge : String to int
        int charge = Integer.parseInt(economyCharge);
        this.economyCharge = charge;
    }

    public void setPrestigeCharge(String prestigeCharge) { // prestigeCharge : String to int
        int charge = Integer.parseInt(prestigeCharge);
        this.prestigeCharge = charge;
    }
}
