package com.multi.hontrip.user.service;

import com.multi.hontrip.user.dao.MyPageDAO;
import com.multi.hontrip.user.dto.MyRecordDTO;
import com.multi.hontrip.user.dto.PageDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService{

    private final MyPageDAO myPageDAO;

    @Override
    public int getRecordTotalCount(Long userId) {   // 기록 부분의 내 기록 전체 가져오기
        String dbName = "record_board";
        return myPageDAO.getTotalCountByUserId(userId, dbName);
    }

    @Override
    public List<MyRecordDTO> getMyRecordList(PageDTO pageDTO,Long userId) {
        return myPageDAO.getRecordListByUserIdAndPage(pageDTO,userId);
    }
}

