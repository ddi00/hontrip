package com.multi.hontrip.mate.dto;

import lombok.Builder;
import lombok.Data;

import java.util.List;
@Data
@Builder
public class JoinChatInfo { //채팅방 입장할 때 필요정보
    // 채팅방 정보
    private Long roomId;    //해당 chat room id
    private String chatRoomName;    //채팅방 이름
    private Long senderId;  //해당 chat sender id - 나중에 세션에서 가져오기
    private Long receiverId;    //해당 chat receiver id - 1:1이라 정해져 있음
    private List<ChatMessageDTO> chatMessages;  // 이전 메세지
    private boolean newFlag;    // 처음 들어온 사람인지
}

