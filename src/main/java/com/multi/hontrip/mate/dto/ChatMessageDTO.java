package com.multi.hontrip.mate.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatMessageDTO {   // 채팅 메세지 주고받은 dto
    private Long messageId;
    private MessageType messageType;    //메세지 타입 - 쓸지 모르겠음
    private Long roomId;    // 방번호
    private Long senderId;  // 보내는 사람 id
    private Long receiverId;    //받는 사람 id
    private String message; // 메세지
    private LocalDateTime sendTime; // 발송시간
}
