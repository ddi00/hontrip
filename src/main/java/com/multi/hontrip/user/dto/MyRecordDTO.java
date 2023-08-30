package com.multi.hontrip.user.dto;

import lombok.Data;

@Data
public class MyRecordDTO {  // 내 목록에서 보여줄 기록 항목
    private int no;             // 번소(rowNum)
    private long boardId;       // 기록 포스트 id
    private String city;        // 도시명
    private String title;       // 제목
    private String thumbnail;   // 썸네일
    private String createdAt;   // 생성일자
    private String updatedAt;   // 수정일자
    private String startDate;   // 여행 시작일
    private String endDate;     // 여행 종료일
    private int isVisible;      // 공개여부
    private int likeCount;      // 좋아요 카운트
    private int cmtCount;       // 코멘트 카운트
}
