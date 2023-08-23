package com.multi.hontrip.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class WithdrawUserDTO {  // 탈퇴 회원정보
    private Long id;
    private String provider;
    private String socialId;
    private String accessToken;
    private LocalDateTime expiresAt;
}
