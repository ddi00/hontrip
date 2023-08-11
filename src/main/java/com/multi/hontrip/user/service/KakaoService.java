package com.multi.hontrip.user.service;

import com.google.gson.Gson;
import com.multi.hontrip.user.dto.KakaoOauthTokenDTO;
import com.multi.hontrip.user.dto.KakaoUserDTO;
import com.multi.hontrip.user.dto.UserInsertDTO;
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

@Service
@PropertySource("classpath:properties/user/kakao.properties")
public class KakaoService { //카카오 oauth 인증 처리
    @Value("${kakao.client.id}")
    private String KAKAO_CLIENT_ID; //카카오 인증 ID
    @Value("${kakao.client.secret}")
    private String KAKAO_CLIENT_SECRET; //카카오 보안 문자열
    @Value("${kakao.redirect.url}")
    private String KAKAO_REDIRECT_URL;  //카카오 callback 처리 경로
    @Value("${kakao.auth.url}")
    private String KAKAO_AUTH_URL;  //카카오 인증 url
    @Value("${kakao.api.url}")
    private String KAKAO_API_URL;   //카카오 api url
    @Value("${kakao.logout.redirect.url}")
    private String KAKAO_LOGOUT_REDIRECT_URI;

    public String getKakaoLogin() {//카카오 인가코드 발급 url
        String kakaoAuthUri = KAKAO_AUTH_URL+"/oauth/authorize"
                + "?client_id=" + KAKAO_CLIENT_ID
                + "&redirect_uri=" + KAKAO_REDIRECT_URL
                + "&response_type=code";
        return kakaoAuthUri;
    }

    public UserInsertDTO getKakaoInfo(String code) throws Exception{  //인증 코드로 접근 토근 받기, POST요청
        if(code==null) throw new Exception("인증코드가 없습니다.");
        KakaoOauthTokenDTO tokenDTO = null;   // 인증 시도 후 반환받을 값

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

    public UserInsertDTO getUserInfoWithToken(KakaoOauthTokenDTO tokenDTO){ //액세스 토큰을 통해 사용자 정보가져오기, POST(get,post 둘다 지원)

        //HttpHeader 생성
        HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.add("Authorization", "Bearer " + tokenDTO.getAccessToken());
        httpHeaders.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");

        //헤더를 오브젝트에 담기
        HttpEntity<MultiValueMap<String, String>> httpEntity = new HttpEntity<>(httpHeaders);

        //Http 요청하기
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(
                KAKAO_API_URL+"/v2/user/me",      //전송 URL
                HttpMethod.POST,    //전송 메서드
                httpEntity, //header, body 데이터
                String.class    //응답받을 값
        );
        Gson gson = new Gson();
        KakaoUserDTO kakaoUserDTO=gson.fromJson(response.getBody(),KakaoUserDTO.class);

        return KakaoUserDTO.convertToUserInsertDTO(tokenDTO, kakaoUserDTO);
    }

    public String getKakaoLogOut() {    //카카오 로그아웃 url 가져오기
        return KAKAO_AUTH_URL+"/oauth/logout?client_id="+KAKAO_CLIENT_ID+"&logout_redirect_uri="+KAKAO_LOGOUT_REDIRECT_URI;
    }
}
