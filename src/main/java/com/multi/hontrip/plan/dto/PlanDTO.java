package com.multi.hontrip.plan.dto;

import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@Builder
@Getter
@Setter
public class PlanDTO {
    private Long id; // 여행 일정 id
    private Long userId; // 사용자 id
    private String title; // 일정 제목
    private Date startDate; // 일정 시작일
    private Date endDate; // 일정 종료일
    private String memo; // 일정 메모
    private LocalDateTime createdAt; // 일정 생성일시
    private LocalDateTime updatedAt; // 일정 수정일시
}


