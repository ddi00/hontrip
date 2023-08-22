package com.multi.hontrip.user.dto;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class UserDTO {  //소셜에서 받아온 사용자 정보
    private Long id;    // 내부 회원 ID
    private String nickName;    //닉네임
    private String profileImage;    //프로필 이미지
    private String ageRange;        //연령대
    private String gender;      //성별
    private String email;   //이메일
    private LocalDateTime expiresAt;    //만료일자
    private LocalDateTime refreshTokenExpiresAt;    //리프레시토큰 만료일자
    private String logOutUrl;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    public String getProfileImage() {
        return profileImage;
    }

    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }

    public String getAgeRange() {
        return ageRange;
    }

    public void setAgeRange(String ageRange) {
        this.ageRange = ageRange;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDateTime getExpiresAt() {
        return expiresAt;
    }

    public void setExpiresAt(LocalDateTime expiresAt) {
        this.expiresAt = expiresAt;
    }

    public LocalDateTime getRefreshTokenExpiresAt() {
        return refreshTokenExpiresAt;
    }

    public void setRefreshTokenExpiresAt(LocalDateTime refreshTokenExpiresAt) {
        this.refreshTokenExpiresAt = refreshTokenExpiresAt;
    }

    public String getLogOutUrl() {
        return logOutUrl;
    }

    public void setLogOutUrl(String logOutUrl) {
        this.logOutUrl = logOutUrl;
    }
}

