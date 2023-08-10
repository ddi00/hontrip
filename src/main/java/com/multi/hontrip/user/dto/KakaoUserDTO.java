package com.multi.hontrip.user.dto;

import com.google.gson.annotations.SerializedName;
import lombok.Data;
@Data
public class KakaoUserDTO {
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
}
