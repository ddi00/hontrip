package com.multi.hontrip.record.dto;

import lombok.Data;


@Data
public class PostInfoDTO {
    private long boardId;
    private String city;
    private String nickName;
    private String title;
    private String imgUrl;
    private String content;
    private String thumbnail;
    private String createdAt;
    private String updatedAt;
    private int isVisible;
    private int likeCount;
    private String cmtUserNickName;
    private String cmtContent;
    private int cmtSequence;
    private int indentationNum;
    private String cmtCreatedAt;
    private String cmtUpdatedAt;
}
