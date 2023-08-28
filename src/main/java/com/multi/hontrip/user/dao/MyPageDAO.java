package com.multi.hontrip.user.dao;

import com.multi.hontrip.user.dto.MyRecordDTO;
import com.multi.hontrip.user.dto.PageDTO;

import java.util.List;

public interface MyPageDAO {
    int getTotalCountByUserId(Long userId, String dbName);

    List<MyRecordDTO> getRecordListByUserIdAndPage(PageDTO pageDTO, Long userId);
}
