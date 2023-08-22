package com.multi.hontrip.user.service;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
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

@Service
@PropertySource("classpath:properties/user/naver.properties")
public class NaverService implements OauthService{
    @Value("${naver.client.id}")
    private String NAVER_CLIENT_ID; //네이버 인증 ID
    @Value("${naver.client.secret}")
    private String NAVER_CLIENT_SECRET; //네이버 보안 문자열
    @Value("${naver.redirect.url}")
    private String NAVER_REDIRECT_URL;  //네이버 callback 처리 경로
    @Value("${naver.auth.url}")
    private String NAVER_AUTH_URL;  //네이버 인증 url
    @Value("${naver.api.url}")
    private String NAVER_API_URL;   //네이버 api url
    @Value("${naver.logout.redirect.url}")
    private String NAVER_LOGOUT_REDIRECT_URI;
    @Value("${naver.ssl.api.url}")
    private String NAVER_SSL_API_URL;

    public String getLoginUrl() {//네이버 인가코드 발급 url
        String naverAuthUri = NAVER_AUTH_URL + "/oauth2.0/authorize"
                + "?response_type=code"
                + "&client_id=" + NAVER_CLIENT_ID
                + "&redirect_uri=" + NAVER_REDIRECT_URL
                + "&&state=" + "hontrip_naver_login";
        return naverAuthUri;
    }

    public UserInsertDTO getOauthInfo(String code, String state) {  //네이버 접근 토큰 발급 요청
        if (code == null) throw new RuntimeException("인증코드가 없습니다.");
        OauthTokenDTO tokenDTO = null;   // 인증 시도 후 반환받을 값

        try {
            //헤더 Object생성 - Content-type: application/x-www-form-urlencoded;charset=utf-8
            HttpHeaders httpHeaders = new HttpHeaders();
            httpHeaders.add("Content-type", "application/x-www-form-urlencoded");

            //body Object생성
            MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
            params.add("grant_type", "authorization_code");
            params.add("client_id", NAVER_CLIENT_ID);
            params.add("client_secret", NAVER_CLIENT_SECRET);
            params.add("code", code);
            params.add("state", state);

            //헤더와 바디를 하나의 오브젝트에 담기
            HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<MultiValueMap<String, String>>(params, httpHeaders);

            // HTTP 요청하기  - Post방식 , 그리고 response 응답받기
            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<String> response = restTemplate.exchange(
                    NAVER_AUTH_URL + "/oauth2.0/token",  //전송 url
                    HttpMethod.POST,    //전송 메서드
                    httpEntity, //header, body 데이터
                    String.class    //응답받을 값
            );

            //응답받은 객체를 OauthTokenVO에 넣어준다.
            Gson gson = new Gson();
            tokenDTO = gson.fromJson(response.getBody(), OauthTokenDTO.class);

        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }

        return getUserInfoWithToken(tokenDTO);
    }

    public UserInsertDTO getUserInfoWithToken(OauthTokenDTO tokenDTO) { //액세스 토큰을 통해 사용자 정보가져오기, POST(get,post 둘다 지원)

        //HttpHeader 생성
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Authorization", tokenDTO.getTokenType() + " " + tokenDTO.getAccessToken());

        //헤더를 오브젝트에 담기
        HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<>(httpHeaders);

        //Http 요청하기
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(
                NAVER_API_URL + "/v1/nid/me",      //전송 URL
                HttpMethod.POST,    //전송 메서드
                httpEntity, //header, body 데이터
                String.class    //응답받을 값
        );
        return jsonConverToDTO(response,tokenDTO);
    }

    public String getLogOutUrl() {  //네이버 로그아웃 url - 네이버는 별도의 로그아웃 처리가 없음
        return "/properties/user/naver/logout";
    }

    @Override
    public String quiteSicalOauth(WithdrawUserDTO withdrawUserDTO) {
        if (withdrawUserDTO.getSocialId() == null) throw new RuntimeException("소셜ID가 없습니다.");

        //헤더 Object생성 - Content-type: application/x-www-form-urlencoded;charset=utf-8
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Content-Type", "application/x-www-form-urlencoded");

        //body Object생성
        MultiValueMap<String, String> params = new LinkedMultiValueMap<String, String>();
        params.add("client_id",NAVER_CLIENT_ID);
        params.add("client_secret",NAVER_CLIENT_SECRET);
        params.add("access_token",withdrawUserDTO.getAccessToken());
        params.add("grant_type","delete");
        params.add("service_provider","NAVER");

        //헤더와 바디를 하나의 오브젝트에 담기
        HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<MultiValueMap<String, String>>(params, httpHeaders);

        // HTTP 요청하기  - Post방식 , 그리고 response 응답받기
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(
                NAVER_SSL_API_URL,  //전송 url
                HttpMethod.POST,    //전송 메서드
                httpEntity, //header, body 데이터
                String.class    //응답받을 값
        );

        String result="fail";
        if (response.getStatusCode().is2xxSuccessful()) {
            String responseBody = response.getBody(); // Get the response body as String
            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(responseBody, JsonObject.class);
            result = jsonObject.get("result").getAsString();
            // Now you can work with the JsonObject as needed
        }

        return result.equals("success") ? "success" : "fail";
    }

    private UserInsertDTO jsonConverToDTO(ResponseEntity<String> response,OauthTokenDTO tokenDTO) { // 입력받은 사용자 json정보를 파싱해서 dto에 넣음
        //json 파싱
        JsonParser parser = new JsonParser();
        JsonElement element = parser.parse(response.getBody());
        String socialId = element.getAsJsonObject().getAsJsonObject("response").get("id").getAsString();
        String nickname = element.getAsJsonObject().getAsJsonObject("response").get("nickname").getAsString();
        String profileImage = element.getAsJsonObject().getAsJsonObject("response").get("profile_image").getAsString();
        int ageRangeId = getIdFromNaverAgeRangeString(element.getAsJsonObject().getAsJsonObject("response").get("age").getAsString());
        int gender = getGenderIdFromNaverGender(element.getAsJsonObject().getAsJsonObject("response").get("gender").getAsString());
        String email = element.getAsJsonObject().getAsJsonObject("response").get("email").getAsString();
        //날짜 적용
        LocalDateTime createdAt = LocalDateTime.now();
        LocalDateTime expiresAt  = createdAt.plus(Duration.ofSeconds(tokenDTO.getExpiresIn()));

        return UserInsertDTO.builder()
                .provider("naver")
                .socialId(socialId)
                .nickName(nickname)
                .profileImage(profileImage)
                .gender(gender)
                .ageRangeId(ageRangeId)
                .email(email)
                .accessToken(tokenDTO.getAccessToken())
                .expiresAt(expiresAt)
                .refreshToken(tokenDTO.getRefreshToken())
                .refreshTokenExpiresAt(null)
                .createdAt(createdAt)
                .build();
    }


    private int getGenderIdFromNaverGender(String gender) { //성별 변환
        // null이면 NONE("정보없음", 1), female이면  FEMALE("여성", 3);, male이면 MALE("남성", 2),
        if ("F".equalsIgnoreCase(gender)) {
            return Gender.FEMALE.getId();
        } else if ("M".equalsIgnoreCase(gender)) {
            return Gender.MALE.getId();
        }else{
            return Gender.NONE.getId();
        }
    }
    private int getIdFromNaverAgeRangeString(String value) { //연령대 변환
        if (value == null) {
            return AgeRange.AGE_UNKNOWN.getId();
        }
        try {
            int age = Integer.parseInt(value.split("-")[0]);
            if (age >= 0 && age <= 9) {
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
