package com.multi.hontrip.plan.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class EmergencyFacilityDTO {
    private Long EmergencyFacilityId;
    private String id;
    private String placeName;
    private String categoryName;
    private String categoryGroupCode;
    private String categoryGroupName;
    private String phone;
    private String addressName;
    private String roadAddressName;
    private String x;
    private String y;
    private String placeUrl;
    private String distance;
}