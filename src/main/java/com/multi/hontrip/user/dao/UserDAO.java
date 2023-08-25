package com.multi.hontrip.user.dao;

import com.multi.hontrip.user.dto.UserInsertDTO;
import com.multi.hontrip.user.dto.UserSocialInfoDTO;
import com.multi.hontrip.user.dto.WithdrawUserDTO;
import org.springframework.transaction.annotation.Transactional;

public interface UserDAO {
    Long findIdByProviderAndSocialID(String provider, String socialId);

    UserInsertDTO saveUserInfo(UserInsertDTO userInsertDTO);

    @Transactional
    UserInsertDTO updateUserInfo(UserInsertDTO userInsertDTO);

    String getProviderById(Long userId);

    void removeAccessToken(Long userId);

    void removeUser(Long id);

    WithdrawUserDTO findSocialInfoById(Long id);

    UserInsertDTO getUserInfoBySessionId(Long userId);

    UserSocialInfoDTO getSocialInfoById(Long userId);
}
