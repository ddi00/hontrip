package com.multi.hontrip.record.dto;

import lombok.Data;

@Data
public class PostLikeDTO {
    private long id;
    private long userId;
    private long recordId;
    private int likeCount;
}
