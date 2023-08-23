package com.multi.hontrip.user.service;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.multi.hontrip.user.dto.*;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

@Service
@PropertySource("classpath:properties/user/kakao.properties")
public class KakaoService implements OauthService { //카카오 oauth 인증 처리
    @Value("${kakao.client.id}")
    private String KAKAO_CLIENT_ID ; //카카오 인증 ID
    @Value("${kakao.client.secret}")
    private String KAKAO_CLIENT_SECRET; //카카오 보안 문자열
    @Value("${kakao.redirect.url}")
    private String KAKAO_REDIRECT_URL;  //카카오 callback 처리 경로
    @Value("${kakao.auth.url}")
    private String KAKAO_AUTH_URL;  //카카오 인증 url
    @Value("${kakao.api.url}")
    private String KAKAO_API_URL;   //카카오 api url
    @Value("${kakao.ssl.api.url}")
    private String KAKAO_SSL_API_URL;   //카카오 api url
    @Value("${kakao.logout.redirect.url}")
    private String KAKAO_LOGOUT_REDIRECT_URI;
    @Value("${kakao.admin.key}")
    private String KAKAO_ADMIN_KEY;

    @Override
    public String getLoginUrl() {//카카오 인가코드 발급 url
        String kakaoAuthUri = KAKAO_AUTH_URL + "/oauth/authorize"
                + "?client_id=" + KAKAO_CLIENT_ID
                + "&redirect_uri=" + KAKAO_REDIRECT_URL
                + "&response_type=code";
        return kakaoAuthUri;
    }

    @Override
    public UserInsertDTO getOauthInfo(String code, String state) {  //인증 코드로 접근 토근 받기, POST요청
        if (code == null) throw new RuntimeException("인증코드가 없습니다.");
        OauthTokenDTO tokenDTO = null;   // 인증 시도 후 반환받을 값

        try {
            //헤더 Object생성 - Content-type: application/x-www-form-urlencoded;charset=utf-8
            HttpHeaders httpHeaders = new HttpHeaders();
            httpHeaders.add("Content-type", "application/x-www-form-urlencoded");

            //body Object생성
            MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
            params.add("grant_type", "authorization_code");
            params.add("client_id", KAKAO_CLIENT_ID);
            params.add("client_secret", KAKAO_CLIENT_SECRET);
            params.add("code", code);
            params.add("redirect_uri", KAKAO_REDIRECT_URL);

            //헤더와 바디를 하나의 오브젝트에 담기
            HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<MultiValueMap<String, String>>(params, httpHeaders);

            // HTTP 요청하기  - Post방식 , 그리고 response 응답받기
            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<String> response = restTemplate.exchange(
                    KAKAO_AUTH_URL + "/oauth/token",  //전송 url
                    HttpMethod.POST,    //전송 메서드
                    httpEntity, //header, body 데이터
                    String.class    //응답받을 값
            );

            //응답받은 객체를 KakaoOauthTokenVO에 넣어준다.
            Gson gson = new Gson();
            tokenDTO = gson.fromJson(response.getBody(), OauthTokenDTO.class);

        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }

        return getUserInfoWithToken(tokenDTO);
    }

    @Override
    public UserInsertDTO getUserInfoWithToken(OauthTokenDTO tokenDTO) { //액세스 토큰을 통해 사용자 정보가져오기, POST(get,post 둘다 지원)

        //HttpHeader 생성
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Authorization", tokenDTO.getTokenType() + " " + tokenDTO.getAccessToken());
        httpHeaders.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        //헤더를 오브젝트에 담기
        HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<>(httpHeaders);

        //Http 요청하기
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(
                KAKAO_API_URL + "/v2/user/me",      //전송 URL
                HttpMethod.POST,    //전송 메서드
                httpEntity, //header, body 데이터
                String.class    //응답받을 값
        );

        return jsonConverToDTO(response, tokenDTO);

    }

    @Override
    public String getLogOutUrl() {    //카카오 로그아웃 url 가져오기
        return KAKAO_AUTH_URL+"/oauth/logout?client_id="+KAKAO_CLIENT_ID+"&logout_redirect_uri="+KAKAO_LOGOUT_REDIRECT_URI;
    }

    @Override
    public String quiteSicalOauth(WithdrawUserDTO withdrawUserDTO) {
        if (withdrawUserDTO.getSocialId() == null) throw new RuntimeException("소셜ID가 없습니다.");

        //헤더 Object생성 - Content-type: application/x-www-form-urlencoded;charset=utf-8
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Content-Type", "application/x-www-form-urlencoded");
        httpHeaders.add("Authorization", "KakaoAK "+KAKAO_ADMIN_KEY);

        //body Object생성
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("target_id_type","user_id");
        params.add("target_id",withdrawUserDTO.getSocialId());

        //헤더와 바디를 하나의 오브젝트에 담기
        HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<MultiValueMap<String, String>>(params, httpHeaders);

        // HTTP 요청하기  - Post방식 , 그리고 response 응답받기
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(
                KAKAO_SSL_API_URL,  //전송 url
                HttpMethod.POST,    //전송 메서드
                httpEntity, //header, body 데이터
                String.class    //응답받을 값
        );

        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(response.getBody());
        Long socialId = element.getAsJsonObject().get("id").getAsLong();

        if(socialId == Long.parseLong(withdrawUserDTO.getSocialId())) {
            return "success";
        }else{
            return "fail";
        }
    }

    private UserInsertDTO jsonConverToDTO(ResponseEntity<String> response, OauthTokenDTO tokenDTO) {
        //json 파싱
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(response.getBody());
        String socialId = element.getAsJsonObject().get("id").getAsString();
        String nickname = element.getAsJsonObject().getAsJsonObject("properties").get("nickname").getAsString();
        String profileImage = element.getAsJsonObject().getAsJsonObject("properties").get("profile_image").getAsString();
        int ageRangeId = getIdFromKakaoAgeRangeString(element.getAsJsonObject().getAsJsonObject("kakao_account").get("age_range").getAsString());
        int gender = getGenderIdFromKakaoGender(element.getAsJsonObject().getAsJsonObject("kakao_account").get("gender").getAsString());
        String email = element.getAsJsonObject().getAsJsonObject("kakao_account").get("email").getAsString();
        String connectedAt = element.getAsJsonObject().get("connected_at").getAsString();
        //날짜 적용
        ZonedDateTime zonedDateTime = ZonedDateTime.parse(connectedAt, DateTimeFormatter.ISO_DATE_TIME);
        LocalDateTime createdAt = zonedDateTime.toLocalDateTime();
        LocalDateTime expiresAt  = LocalDateTime.now().plus(Duration.ofSeconds(tokenDTO.getExpiresIn()));
        LocalDateTime refreshTokenExpiresAt = LocalDateTime.now().plus(Duration.ofSeconds(tokenDTO.getRefreshTokenExpiresIn()));

        return UserInsertDTO.builder()
                .provider("kakao")
                .socialId(socialId)
                .nickName(nickname)
                .profileImage(profileImage)
                .gender(gender)
                .ageRangeId(ageRangeId)
                .email(email)
                .accessToken(tokenDTO.getAccessToken())
                .expiresAt(expiresAt)
                .refreshToken(tokenDTO.getRefreshToken())
                .refreshTokenExpiresAt(refreshTokenExpiresAt)
                .createdAt(createdAt)
                .build();
    }


    private int getGenderIdFromKakaoGender(String gender) { //성별 변환
        // null이면 NONE("정보없음", 1), female이면  FEMALE("여성", 3);, male이면 MALE("남성", 2),
        if ("female".equalsIgnoreCase(gender)) {
            return Gender.FEMALE.getId();
        } else if ("male".equalsIgnoreCase(gender)) {
            return Gender.MALE.getId();
        }else{
            return Gender.NONE.getId();
        }
    }
    private int getIdFromKakaoAgeRangeString(String value) { //연령대 변환
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
