package com.multi.hontrip.record.dto;

import lombok.Data;

@Data
public class CreatePostDTO {
    private long id;
    private long userId;
    private long locationId;
    private String title;
    private String content;
    private int isVisible;
    private String thumbnail;
    private String createdAt;
    private String updatedAt;
}