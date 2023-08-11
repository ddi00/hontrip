package com.multi.hontrip.user.dto;

import com.google.gson.annotations.SerializedName;
import lombok.Data;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

@Data
public class KakaoUserDTO { // kakao 사용자 정보 -  자세한 사항은 https://developers.kakao.com/docs/latest/ko/kakaologin/rest-api 문서 참조
    private Long id;

    @SerializedName("connected_at")
    private String connectedAt;

    private Properties properties;

    @SerializedName("kakao_account")
    private KakaoAccount kakaoAccount;

    @Data
    public static class Properties {
        private String nickname;
        @SerializedName("profile_image")
        private String profileImage;
        @SerializedName("thumbnail_image")
        private String thumbnailImage;
    }

    @Data
    public static class KakaoAccount {
        @SerializedName("profile_nickname_needs_agreement")
        private boolean profileNicknameNeedsAgreement;
        @SerializedName("profile_image_needs_agreement")
        private boolean profileImageNeedsAgreement;
        private Profile profile;

        @Data
        public static class Profile {
            private String nickname;
            @SerializedName("thumbnail_image_url")
            private String thumbnailImageUrl;
            @SerializedName("profile_image_url")
            private String profileImageUrl;
            @SerializedName("is_default_image")
            private boolean isDefaultImage;
        }

        private boolean hasEmail;
        @SerializedName("email_needs_agreement")
        private boolean emailNeedsAgreement;
        @SerializedName("is_email_valid")
        private boolean isEmailValid;
        @SerializedName("is_email_verified")
        private boolean isEmailVerified;
        private String email;

        private boolean hasAgeRange;
        @SerializedName("age_range_needs_agreement")
        private boolean ageRangeNeedsAgreement;
        @SerializedName("age_range")
        private String ageRange;

        private boolean hasGender;
        @SerializedName("gender_needs_agreement")
        private boolean genderNeedsAgreement;
        private String gender;
    }

    public static UserInsertDTO convertToUserInsertDTO(KakaoOauthTokenDTO tokenDTO,KakaoUserDTO kakaoUserDTO) {

        ZonedDateTime zonedDateTime = ZonedDateTime.parse(kakaoUserDTO.getConnectedAt(), DateTimeFormatter.ISO_DATE_TIME);
        LocalDateTime createdAt = zonedDateTime.toLocalDateTime();
        LocalDateTime expiresAt  = LocalDateTime.now().plus(Duration.ofSeconds(tokenDTO.getExpiresIn()));
        LocalDateTime refreshTokenExpiresAt = LocalDateTime.now().plus(Duration.ofSeconds(tokenDTO.getRefreshTokenExpiresIn()));

        int ageRangeId=getIdFromKakaoAgeRangeString(kakaoUserDTO.getKakaoAccount().getAgeRange());

        int gender = getGenderIdFromKakaoGender(kakaoUserDTO.getKakaoAccount().getGender());

        return UserInsertDTO.builder()
                .provider("kakao")
                .socialId(kakaoUserDTO.getId())
                .nickName(kakaoUserDTO.getProperties().getNickname())
                .profileImage(kakaoUserDTO.getKakaoAccount().getProfile().getProfileImageUrl())
                .gender(gender)
                .ageRangeId(ageRangeId)
                .email(kakaoUserDTO.getKakaoAccount().getEmail())
                .accessToken(tokenDTO.getAccessToken())
                .expiresAt(expiresAt)
                .refreshToken(tokenDTO.getRefreshToken())
                .refreshTokenExpiresAt(refreshTokenExpiresAt)
                .createdAt(createdAt)
                .build();
    }
    private static int getGenderIdFromKakaoGender(String gender) { //성별 변환
        // null이면 NONE("정보없음", 1), female이면  FEMALE("여성", 3);, male이면 MALE("남성", 2),
        if ("female".equalsIgnoreCase(gender)) {
            return Gender.FEMALE.getId();
        } else if ("male".equalsIgnoreCase(gender)) {
            return Gender.MALE.getId();
        }else{
            return Gender.NONE.getId();
        }
    }

    public static int getIdFromKakaoAgeRangeString(String value) { //연령대 변환
        if (value == null) {
            return AgeRange.AGE_UNKNOWN.getId();
        }
        try {
            int age = Integer.parseInt(value.split("~")[0]);
            if (age >= 1 && age <= 9) {
                return AgeRange.AGE_0_9.getId();
            } else if (age >= 10 && age <= 19) {
                return AgeRange.AGE_10_19.getId();
            } else if (age >= 20 && age <= 29) {
                return AgeRange.AGE_20_29.getId();
            } else if (age >= 30 && age <= 39) {
                return AgeRange.AGE_30_39.getId();
            } else if (age >= 40 && age <= 49) {
                return AgeRange.AGE_40_49.getId();
            } else if (age >= 50 && age <= 59) {
                return AgeRange.AGE_50_59.getId();
            } else if (age >= 60) {
                return AgeRange.AGE_60_PLUS.getId();
            } else {    // 나이가 음수 등 형식에 맞지 않는 경우 처리
                return AgeRange.AGE_UNKNOWN.getId();
            }
        } catch (NumberFormatException e) { // 문자열을 정수로 변환할 수 없는 경우 처리
            return AgeRange.AGE_UNKNOWN.getId();
        }
    }
}
