package com.multi.hontrip.mate.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MateApplicationNotificationDTO {
    private long id;
    private String mateBoardURL;
    private long receiverId;
    private long senderId;
    private String content;
    private LocalDateTime createdAt;
    private boolean isRead;
}
