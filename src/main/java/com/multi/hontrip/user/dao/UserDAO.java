package com.multi.hontrip.user.dao;

import com.multi.hontrip.user.dto.UserDTO;
import com.multi.hontrip.user.dto.UserInsertDTO;
import com.multi.hontrip.user.dto.WithdrawUserDTO;
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
    public Long findIdByProviderAndSocialID(String provider, String socialId) {   //카카오 인증정보로 기존 회원인지 확인, 없으면 null
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
        return sqlSessionTemplate.selectOne("userMapper.userInfobyUpdated");   // 사용자 정보 다시 가져오기
    }

    public String getProviderById(Long userId) {  //provider 가져오기
        return sqlSessionTemplate.selectOne("userMapper.userProvider", userId);
    }

    public void removeAccessToken(Long userId) {    // user 로그아웃시 access토큰 관련 정보 삭제
        sqlSessionTemplate.update("userMapper.userAccessTokenRemove", userId);
    }


    public void removeUser(Long id) {    //user테이블 사용자 제거
        sqlSessionTemplate.delete("userMapper.deleteUserById", id);
    }

    public WithdrawUserDTO findSocialInfoById(Long id) {   //id로 social정보 가져오기
        return sqlSessionTemplate.selectOne("userMapper.findProviderAndSocialIDById",id);
    }

    public UserInsertDTO getUserInfoBySessionId(Long userId) {    //세션아이디로 사용자 정보 가져오기
        return sqlSessionTemplate.selectOne("userMapper.findUserInfoBySessionId",userId);
    }
}
