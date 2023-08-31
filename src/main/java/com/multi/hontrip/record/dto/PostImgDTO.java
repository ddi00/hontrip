package com.multi.hontrip.record.dto;

import lombok.Data;

@Data
public class PostImgDTO {
    private long imgId;
    private String imgUrl; // 게시물 이미지
    private long recordId;
}
