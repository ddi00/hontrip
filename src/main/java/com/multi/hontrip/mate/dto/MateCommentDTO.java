package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class MateCommentDTO {
    private long commentId;
    private long MateBoardId;
    private long userId;
    private String content;
    private String commentSequence;
    private String commentsSequence;
    private String indentationNumber;
    private String createdAt;
    private String updatedAt;
    private String nickname;
}
