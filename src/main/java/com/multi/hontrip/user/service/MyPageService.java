package com.multi.hontrip.user.service;

import com.multi.hontrip.user.dto.PageConditionDTO;

import java.util.Map;

public interface MyPageService {
    Map<String, Object> getMyPageResult(Long userId, PageConditionDTO pageConditionDTO);
}
