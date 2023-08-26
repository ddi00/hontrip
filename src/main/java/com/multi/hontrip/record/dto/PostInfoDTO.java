package com.multi.hontrip.record.dto;

import lombok.Data;


@Data
public class PostInfoDTO {
    private long boardId;
    private long userId;
    private String city;
    private String nickName;
    private String pofileImg;
    private String title;
    private String imgUrl;
    private String content;
    private String thumbnail;
    private String createdAt;
    private String updatedAt;
    private String startDate;
    private String endDate;
    private int isVisible;
    private int likeCount;
    private int cmtCount;
    private long locationId;
}
