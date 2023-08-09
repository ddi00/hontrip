package com.multi.hontrip.plan.dto;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@Getter
@Setter
public class PlanDTO {
    private Long id; // 여행 일정 id
    private Long user_id; // 사용자 id
    private String title; // 일정 제목
    private Date start_date; // 일정 시작일
    private Date end_date; // 일정 종료일
    private String memo; // 일정 메모
    private LocalDateTime created_at; // 일정 생성일시
    private LocalDateTime updated_at; // 일정 수정일시
}


