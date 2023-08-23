package com.multi.hontrip.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserInfoDTO {  // 회원 정보 - 화면에 뿌려줄 문구
    private String provider;    // 회원가입 제공자
    private String nickName;    // 닉네임
    private String profileImage;    // 프로필 이미지
    private String gender;  // 성별 - null 이면 다시 동의받기
    private String ageRange;    // 연령대 - null이면 다시 동의받기
    private String email;   // 이메일 - null 이면 다시 동의받기
}
