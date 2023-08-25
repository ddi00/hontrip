package com.multi.hontrip.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class UserSocialInfoDTO {// 사용자 소셜 정보
    private String provider;
    private String socialId;
    private String accessToken;
    private LocalDateTime expiresAt;
    private String refreshToken;
    private LocalDateTime refreshTokenExpiresAt;
}
