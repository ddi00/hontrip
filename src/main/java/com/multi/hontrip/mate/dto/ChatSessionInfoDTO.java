package com.multi.hontrip.mate.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatSessionInfoDTO {
    private Long roomId;    //해당 chat room id
    private String chatRoomName;    //채팅방이름
    private Long senderId;  //해당 chat sender id
    private Long receiverId;    //해당 chat receiver id - 1:1이라 정해져 있음
}
