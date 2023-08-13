package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dto.*;

import java.util.List;

public interface MateService {

    public void insert(MateBoardInsertDTO mateBoardInsertDTO); //동행인 게시글 작성하기

    public MateBoardInsertDTO selectOne(long id);    //동행인 상세게시글 가져오기

    public UserGenderAgeDTO findUserGenderAgeById(long id);  //동행 신청자의 성별과 연령대 가져오기

    public int insertMatchingAlarm(MateMatchingAlarmDTO mateMatchingAlarmDTO); //동행인 신청 메세지 작성하기

    public int checkApply(MateMatchingAlarmDTO mateMatchingAlarmDTO); //동행인 게시글 신청여부 확인

    List<MateBoardListDTO> list(PageDTO pageDTO); //게시물 리스트 가져오기

    int count(); //게시물 개수 가져오기

    List<LocationDTO> location(); //지역 리스트 가져오기

    public int pages(int count); //전체 페이지 수 구하기
}
