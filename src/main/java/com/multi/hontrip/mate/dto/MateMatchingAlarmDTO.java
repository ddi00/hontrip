package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class MateMatchingAlarmDTO {

    public enum AlarmType {
        MATE_APPLY, MATE_CHAT, MATE_COMMENT, MATE_ACCOMPANY_CONFIRMED
    }


    private long id;
    private AlarmType alarmType;    //알람 타입 (동행인신청 알람 or 채팅알람 or 동행인 댓글알람)
    private long roomId;    //채팅방 아이디
    private long mateBoardId;   //동행 신청한 게시판 아이디
    private String mateBoardTitle; //동행 신청한 게시판의 제목
    private long receiverId;    //동행 게시판 작성자 아이디(모집자)
    private long senderId;  //동행 신청한 유저의 아이디(신청자)
    private String senderNickname;    //동행 신청한 유저의 닉네임(신청자)
    private String senderProfileImage;   //동행 신청한 유저의 썸네일(신청자)
    private String content;     //동행 신청 메세지 내용
    private int isRead;     //알림을 읽었는가 1읽음 0안읽음

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

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

    public String getSenderNickname() {
        return senderNickname;
    }

    public void setSenderNickname(String senderNickname) {
        this.senderNickname = senderNickname;
    }

    public String getSenderProfileImage() {
        return senderProfileImage;
    }

    public void setSenderProfileImage(String senderProfileImage) {
        this.senderProfileImage = senderProfileImage;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
