package com.multi.hontrip.record.dto;

import lombok.Data;

@Data
public class CreateCommentDTO {
    private long id;
    private long cmtWriterId;
    private long recordId;
    private String cmtContent;
    private int cmtSequence;
    private int cmtsSequence;
    private int indentationNum;
}
