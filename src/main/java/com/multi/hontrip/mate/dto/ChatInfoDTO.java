package com.multi.hontrip.mate.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatInfoDTO {  // 채팅방 만들 정보
    private Long roomId;
    private String chatRoomName;   // 채팅방 타이틀
    private Long postId;    // 게시물 아이디 - 모집하는 게시물 Id
    private Long ownerId;   // 모집자 아이디
    private Long guestId;   // 신청자 아이디
}
