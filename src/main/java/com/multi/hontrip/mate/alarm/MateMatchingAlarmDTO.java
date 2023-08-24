package com.multi.hontrip.mate.alarm;

import lombok.Data;

@Data
public class MateMatchingAlarmDTO {

    private long mateBoardId;   //동행 신청한 게시판 아이디
    private long receiverId;    //동행 게시판 작성자 아이디(신청받는자)
    private long senderId;      //동행 신청한 유저 아이디(신청하는자)
    private String content;     //동행 신청 메세지 내용

    public long getMateBoardId() {
        return mateBoardId;
    }

    public void setMateBoardId(long mateBoardId) {
        this.mateBoardId = mateBoardId;
    }

    public long getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(long receiverId) {
        this.receiverId = receiverId;
    }

    public long getSenderId() {
        return senderId;
    }

    public void setSenderId(long senderId) {
        this.senderId = senderId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
