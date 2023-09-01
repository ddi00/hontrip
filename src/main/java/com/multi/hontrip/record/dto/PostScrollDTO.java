package com.multi.hontrip.record.dto;

import lombok.Data;

@Data
public class PostScrollDTO {

    private long userId;

    // 무한 스크롤 위한 필드
    private int startRowNum; // 시작 번호
    private int endRowNum;  // 끝 번호
    private int rowCount; // 가져갈 개수
}
