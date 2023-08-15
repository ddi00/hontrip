package com.multi.hontrip.plan.dto;

import lombok.Data;

@Data
public class FlightDTO {

    private Long id;
    private String vehicleId;
    private String airlineName;
    private String depAirportName;
    private String departureTime;
    private String arrAirportName;
    private String arrivalTime;
    private int economyCharge;
    private int prestigeCharge;

    public void setEconomyCharge(String economyCharge) {
        int charge = Integer.parseInt(economyCharge);
        this.economyCharge = charge;
    }

    public void setPrestigeCharge(String prestigeCharge) {
        int charge = Integer.parseInt(prestigeCharge);
        this.prestigeCharge = charge;
    }
}
