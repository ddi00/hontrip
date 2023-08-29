package com.multi.hontrip.record.dto;

import lombok.Data;

@Data
public class PostLikeDTO {
    private long likeId;
    private long userId;
    private long recordId;
    private String likeUserNickname;
    private int likeCount;
}
