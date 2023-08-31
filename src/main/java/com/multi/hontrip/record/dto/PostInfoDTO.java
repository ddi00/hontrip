package com.multi.hontrip.record.dto;

import lombok.Data;


@Data
public class PostInfoDTO {
    private long boardId;
    private long userId;
    private long views;
    private String city;
    private String nickName;
    private String pofileImg;
    private String title;
    private String content;
    private String thumbnail;
    private String createdAt;
    private String updatedAt;
    private String startDate; // 여행시작 날짜
    private String endDate; // 여행종료 날짜
    private int isVisible; // 공개 비공개
    private int likeCount;
    private int cmtCount; // 댓글 수
    private long locationId;
}
