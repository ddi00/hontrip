package com.multi.hontrip.user.dto;

import com.google.gson.annotations.SerializedName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

@Data
@Builder
@AllArgsConstructor
public class OauthTokenDTO {   //사용자 정보 접근 토큰
    @SerializedName("token_type")
    private String tokenType;   //토큰 타입
    @SerializedName("access_token")
    private String accessToken; //사용자 액세스 토큰값
    @SerializedName("expires_in")
    private int expiresIn;  //토큰 만료 시간
    @SerializedName("refresh_token")
    private String refreshToken;    //사용자 리프레시 토큰 값
    @SerializedName("refresh_token_expires_in")
    private int refreshTokenExpiresIn;  //리프레시 토큰 만료 시간
    @SerializedName("scope")
    private String scope;   // 인증된 사용자 정보 조회 권한 범위

    public String getTokenType() {
        return tokenType;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public int getExpiresIn() {
        return expiresIn;
    }

    public void setExpiresIn(int expiresIn) {
        this.expiresIn = expiresIn;
    }

    public String getRefreshToken() {
        return refreshToken;
    }

    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
    }

    public int getRefreshTokenExpiresIn() {
        return refreshTokenExpiresIn;
    }

    public void setRefreshTokenExpiresIn(int refreshTokenExpiresIn) {
        this.refreshTokenExpiresIn = refreshTokenExpiresIn;
    }

    public String getScope() {
        return scope;
    }

    public void setScope(String scope) {
        this.scope = scope;
    }
}
