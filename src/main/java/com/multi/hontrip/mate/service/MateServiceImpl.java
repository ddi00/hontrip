package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dao.MateDAO;
import com.multi.hontrip.mate.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MateServiceImpl implements MateService {

    @Autowired
    MateDAO mateDAO;

    //동행인 게시글 작성하기
    @Override
    public void insert(MateBoardInsertDTO mateBoardInsertDTO) {
        mateDAO.mateBoardInsert(mateBoardInsertDTO);
    }


    //동행인 상세게시글 가져오기
    @Override
    public MateBoardInsertDTO selectOne(long id) {
        return mateDAO.mateBoardSelectOne(id);
    }

    //동행 신청자의 성별과 연령대 가져오기
    @Override
    public UserGenderAgeDTO findUserGenderAgeById(long id) {
        return mateDAO.findUserGenderAgeById(id);
    }

    //동행 신청 메세지 전송하기
    @Override
    public int insertMatchingAlarm(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        return mateDAO.insertMatchingAlarm(mateMatchingAlarmDTO);
    }

    @Override
    public int checkApply(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        return mateDAO.checkApply(mateMatchingAlarmDTO);
    }

    @Override
    public List<MateBoardListDTO> list(PageDTO pageDTO) {
        pageDTO.setStartEnd(pageDTO.getPage());
        return mateDAO.list(pageDTO);
    }

    @Override
    public int pages(int count) {
        int pages = 0;
        if (count % 10 == 0) {
            pages = count / 5; //120개 --> 12pages
        } else {
            pages = count / 5 + 1; //122개 --> 13pages
        }
        return pages;
    }

    @Override
    public int count() {
        return mateDAO.count();
    }

    @Override
    public List<LocationDTO> location() {
        return mateDAO.location();
    }
}

