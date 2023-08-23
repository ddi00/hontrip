package com.multi.hontrip.plan.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.sql.Date;

@Data
@Getter
@Setter
public class PlanDayDTO {
    private Long id; // 여행 일정 상세 id
    private Long planId; // 부모 여행 일정 id (plan_id)
    private Date dayDate; // 여행 일자
    private String daySummary; // 일자별 요약

    public PlanDayDTO(Long planId, Date dayDate, String daySummary) {
        this.planId = planId;
        this.dayDate = dayDate;
        this.daySummary = daySummary;
    }

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
