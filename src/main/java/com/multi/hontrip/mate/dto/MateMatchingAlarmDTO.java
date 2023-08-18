package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class MateMatchingAlarmDTO {

    private long id;            //동행인 알림 id
    private long mateBoardId;   //동행 신청한 게시판 아이디
    private long senderId;      //동행 신청한 유저 아이디
    private String content;     //동행 신청 메세지 내용
}
