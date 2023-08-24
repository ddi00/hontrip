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
    private int cmtSequence; // 답글이면 1 아니면 0
    private int indentationNum; // 모댓글의 cmtId값
    private String cmtCreatedAt;
    private String cmtUpdatedAt;
}
