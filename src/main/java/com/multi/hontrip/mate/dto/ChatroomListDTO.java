package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class ChatroomListDTO {
    private Long roomId;    //해당 chat room id
    private String chatRoomName;    //채팅방이름
    private String opponentProfileImg;
    /*private Long senderId;  //해당 chat sender id
    private Long receiverId;    //해당 chat receiver id - 1:1이라 정해져 있음*/
    private String lastMessage;    //해당 chatRoom의 마지막 채팅메세지
}
