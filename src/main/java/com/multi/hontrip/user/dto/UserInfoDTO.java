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

    public static UserInfoDTO convertFromUserDTO(UserInsertDTO userDTO){    //UserInsertDTO(DB에 넣는 데이터)를 UserInfoDTO(화면에 보여주는 데이터)로 변경
        String gender = Gender.getDescriptionFromId(userDTO.getGender());
        String ageRange = AgeRange.getDescriptionFromId(userDTO.getAgeRangeId());   // TODO 디비로 조인했어야 했음

        return UserInfoDTO.builder()
                .provider(userDTO.getProvider())
                .nickName(userDTO.getNickName())
                .profileImage(userDTO.getProfileImage())
                .email(userDTO.getEmail())
                .gender(gender)
                .ageRange(ageRange)
                .build();
    }
}
