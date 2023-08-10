package com.multi.hontrip.user.dao;

import com.multi.hontrip.user.dto.UserDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class UserDAO {
    private final SqlSessionTemplate sqlSessionTemplate;
    public Long findIdByProviderAndSocialID(String provider, Long socialId) {
        Map<String, Object> params = new HashMap<>();
        params.put("provider", provider);
        params.put("social_id", socialId);
        return sqlSessionTemplate.selectOne("user.findIdByProviderAndSocialID");
    }

    public void saveUserInfo(UserDTO member) {  //user정보 저장

    }

    public void updateUserInfo(UserDTO member) {    //user_id로 신규 정보만 update

    }
}
