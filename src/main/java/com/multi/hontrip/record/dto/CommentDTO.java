package com.multi.hontrip.record.dto;

import lombok.Data;

@Data
public class CommentDTO {
    private long cmtId;
    private String cmtUserNickName;
    private String profileImg;
    private String cmtContent;
    private int cmtSequence;
    private int cmtsSquence;
    private int indentationNum;
    private String cmtCreatedAt;
    private String cmtUpdatedAt;
}
