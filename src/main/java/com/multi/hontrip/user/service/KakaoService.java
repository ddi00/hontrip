package com.multi.hontrip.user.service;

import com.google.gson.Gson;
import com.multi.hontrip.user.dto.KakaoOauthTokenDTO;
import com.multi.hontrip.user.dto.KakaoUserDTO;
import com.multi.hontrip.user.dto.UserDTO;
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
public class KakaoService {
    @Value("${kakao.client.id}")
    private String KAKAO_CLIENT_ID;

    @Value("${kakao.client.secret}")
    private String KAKAO_CLIENT_SECRET;

    @Value("${kakao.redirect.url}")
    private String KAKAO_REDIRECT_URL;

    @Value("${kakao.auth.url}")
    private String KAKAO_AUTH_URL;

    @Value("${kakao.api.url}")
    private String KAKAO_API_URL;


    public String getKakaoLogin() {
        //카카오 인가코드 발급 url : https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=${REST_API_KEY}&redirect_uri=${REDIRECT_URI}
        String kakaoAuthUri = KAKAO_AUTH_URL+"/oauth/authorize"
                + "?client_id=" + KAKAO_CLIENT_ID
                + "&redirect_uri=" + KAKAO_REDIRECT_URL
                + "&response_type=code";
        return kakaoAuthUri;
    }

    public UserDTO getKakaoInfo(String code) throws Exception{  //인증 코드로 접근 토근 받기, POST요청
        if(code==null) throw new Exception("인증코드가 없습니다.");
        KakaoOauthTokenDTO tokenDTO = null;   // 인증 시도 후 반환받을 값

//        요청 : POST "https://kauth.kakao.com/oauth/token"
//        헤더 : "Content-Type: application/x-www-form-urlencoded" \
//        바디  "grant_type=authorization_code", "client_id=${REST_API_KEY}", "redirect_uri=${REDIRECT_URI}","code=${AUTHORIZE_CODE}"

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
            tokenDTO = gson.fromJson(response.getBody(), KakaoOauthTokenDTO.class);

        }catch (Exception e){
            throw new Exception(e.getMessage());
        }

        return getUserInfoWithToken(tokenDTO);
    }

    public UserDTO getUserInfoWithToken(KakaoOauthTokenDTO tokenDTO){ //액세스 토큰을 통해 사용자 정보가져오기, POST(get,post 둘다 지원)

        // GET/POST	https://kapi.kakao.com/v2/user/me -> 나는 post선택
        // 헤더 : Authorization: Bearer ${ACCESS_TOKEN}, Content-type: application/x-www-form-urlencoded;charset=utf-8
        // 바디 : 필수X

        //HttpHeader 생성
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Authorization", "Bearer " + tokenDTO.getAccessToken());
        httpHeaders.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        //헤더를 오브젝트에 담기
        HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<>(httpHeaders);

        //Http 요청하기
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(
                KAKAO_API_URL,      //전송 URL
                HttpMethod.POST,    //전송 메서드
                httpEntity, //header, body 데이터
                String.class    //응답받을 값
        );
        Gson gson = new Gson();
        KakaoUserDTO kakaoUserDTO=gson.fromJson(response.getBody(),KakaoUserDTO.class);

        kakaoUserDTO.toString();

        ZonedDateTime zonedDateTime = ZonedDateTime.parse(kakaoUserDTO.getConnectedAt(), DateTimeFormatter.ISO_DATE_TIME);
        LocalDateTime createdAt = zonedDateTime.toLocalDateTime();
        LocalDateTime expiresAt  = LocalDateTime.now().plus(Duration.ofSeconds(tokenDTO.getExpiresIn()));
        LocalDateTime refreshTockenExpiresAt = LocalDateTime.now().plus(Duration.ofSeconds(tokenDTO.getRefreshTokenExpiresIn()));

        return UserDTO.builder()
                    .provider("KAKAO")
                    .socialId(kakaoUserDTO.getId())
                    .nickName(kakaoUserDTO.getProperties().getNickname())
                    .profileImage(kakaoUserDTO.getKakaoAccount().getProfile().getProfileImageUrl())
                    .gender(kakaoUserDTO.getKakaoAccount().getGender())
                    .ageRange(kakaoUserDTO.getKakaoAccount().getAgeRange())
                    .email(kakaoUserDTO.getKakaoAccount().getEmail())
                    .accessTocken(tokenDTO.getAccessToken())
                    .expiresAt(expiresAt)
                    .refreshToken(tokenDTO.getRefreshToken())
                    .refreshTokenExpiresAt(refreshTockenExpiresAt)
                    .createdAt(createdAt)
                    .build();
    }

}
