package com.multi.hontrip.user.dao;

import com.multi.hontrip.user.dto.UserInsertDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class UserDAO {
    private final SqlSessionTemplate sqlSessionTemplate;
    public Long findIdByProviderAndSocialID(String provider, Long socialId) {   //카카오 인증정보로 기존 회원인지 확인, 없으면 null
        Map<String, Object> params = new HashMap<>();   //파라미터 담기
        params.put("provider", provider);
        params.put("socialId", socialId);
        return sqlSessionTemplate.selectOne("userMapper.findIdByProviderAndSocialID",params);
    }

    public UserInsertDTO saveUserInfo(UserInsertDTO userInsertDTO) {  //user정보 저장, user의 id가 포함된 정보 반환
        sqlSessionTemplate.insert("userMapper.insertMemberByAuth",userInsertDTO);
        return userInsertDTO;
    }

    @Transactional
    public UserInsertDTO updateUserInfo(UserInsertDTO userInsertDTO) {    //user_id로 신규 정보만 update, 신규 정보 반환
        sqlSessionTemplate.update("userMapper.updateMemberByAuth",userInsertDTO);   //사용자 정보 update
        UserInsertDTO updatedUserInsertDTO = sqlSessionTemplate.selectOne("userMapper.userInfbyUpdated");   // 사용자 정보 다시 가져오기
        return updatedUserInsertDTO;   
    }
}
