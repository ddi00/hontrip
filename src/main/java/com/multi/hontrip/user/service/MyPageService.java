package com.multi.hontrip.user.service;

import com.multi.hontrip.user.dto.MyRecordDTO;
import com.multi.hontrip.user.dto.PageDTO;

import java.util.List;

public interface MyPageService {
    int getRecordTotalCount(Long userId);   // 내 전체 레코드 가져오기

    List<MyRecordDTO> getMyRecordList(PageDTO pageDTO,Long userId); //레코드 리스트 가져오기
}
