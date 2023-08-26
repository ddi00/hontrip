package com.multi.hontrip.plan.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Data
@Getter
@Setter
public class PlanDayDTO {
//    private Long id;        // 일정-일 id
    private Long userId;    // 유저 id
    private Long planId;    // 일정 id
    private String spotId;    // 여행지 id
    private String accommodationId;   // 숙박 id
    private String flightId;      // 항공편 id
    private int dayOrder;       // day 순서
}

/*@Data
@Getter
@Setter
public class PlanDayDTO {
    private Long id;
    private Long planId;
    private Long spotId;
    private Long accommodationId;
    private Long flightId;
    private Integer dayOrder; // 여행일 순서 (ex. day1, day2, ...)
    private String itemType;  // 아이템 유형 (ex. spot, accommodation, flight)
    private Integer itemOrder; // 아이템 순서 (ex, 1, 2, 3)
}*/