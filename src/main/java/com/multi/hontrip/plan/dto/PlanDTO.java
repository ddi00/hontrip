package com.multi.hontrip.plan.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;
import java.util.Date;

@Data
@Getter
@Setter
public class PlanDTO {

    private Long id; // 여행 일정 id

    private Long userId; // 사용자 id

    private String title; // 일정 제목

    private Date startDate; // 일정 시작일

    private Date endDate; // 일정 종료일

    private String memo; // 일정 메모

    private Timestamp createdAt; // 일정 생성일시

    private Timestamp updatedAt; // 일정 수정일시

}


