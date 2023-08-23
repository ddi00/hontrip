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
public class UserDTO {  //소셜에서 받아온 사용자 정보
    private Long id;    // 내부 회원 ID
    private String nickName;    //닉네임
    private String profileImage;    //프로필 이미지
    private String ageRange;        //연령대
    private String gender;      //성별
    private String email;   //이메일
    private LocalDateTime expiresAt;    //만료일자
    private LocalDateTime refreshTokenExpiresAt;    //리프레시토큰 만료일자
}

