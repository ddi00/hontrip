package com.multi.hontrip.record.dto;

import lombok.Data;

@Data
public class CommentDTO {
    private long cmtId;
    private long cmtWriterId;
    private long recordId;
    private String cmtUserNickName;
    private String profileImg;
    private String cmtContent;
    private int cmtSequence;
    private int cmtsSequence;
    private int indentationNum;
    private String cmtCreatedAt;
    private String cmtUpdatedAt;
}
