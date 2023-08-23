package com.multi.hontrip.record.dto;

import lombok.Data;

@Data
public class LocationDTO {
    private long id;
    private String city;
    private double lat;
    private double lon;
}
