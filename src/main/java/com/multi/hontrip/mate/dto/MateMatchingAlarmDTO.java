package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class MateMatchingAlarmDTO {

    private long id;
    private long mateBoardId;
    private long senderId;
    private String content;
}
