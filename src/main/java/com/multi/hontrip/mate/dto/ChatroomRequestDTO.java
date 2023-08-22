package com.multi.hontrip.mate.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ChatroomRequestDTO {   // 룸정보 가져오기 위한 dto
    private Long roomId;    //해당 chat room id
    private Long senderId;  //해당 chat sender id - 나중에 세션에서 가져오기
}
