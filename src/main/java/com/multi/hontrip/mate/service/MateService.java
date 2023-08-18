package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dto.*;

import java.util.List;

public interface MateService {
    List<MateBoardListDTO> list(PageDTO pageDTO); //게시물 리스트 가져오기

    MateBoardListDTO one(long mateBoardId); //게시물 상세 가져오기

    List<MateCommentDTO> commentList(long mateBoardId); //게시물 상세의 댓글 목록 가져오기

    int commentInsert(MateCommentDTO mateCommentDTO);

    PageDTO paging(PageDTO pageDTO);

    List<LocationDTO> location(); //지역 리스트 가져오기

    int pages(int count); //전체 페이지 수 구하기

    public void insert(MateBoardInsertDTO mateBoardInsertDTO); //동행인 게시글 작성하기

<<<<<<<HEAD

    public MateBoardInsertDTO selectOne(long id);    //동행인 상세게시글 가져오기

    public int updateMateBoard(MateBoardInsertDTO mateBoardInsertDTO); //동행인 상세게시글 수정하기

    public int deleteMateBoard(long id); //동행인 게시글 삭제하기

    public UserGenderAgeDTO findUserGenderAgeById(long id);  //동행 신청자의 성별과 연령대 가져오기

    public int insertMatchingAlarm(MateMatchingAlarmDTO mateMatchingAlarmDTO); //동행인 신청 메세지 작성하기

    public int checkApply(MateMatchingAlarmDTO mateMatchingAlarmDTO); //동행인 게시글 신청여부 확인

    List<MateBoardListDTO> list(PageDTO pageDTO); //게시물 리스트 가져오기

    int count(); //게시물 개수 가져오기

    List<LocationDTO> location(); //지역 리스트 가져오기

    public int pages(int count); //전체 페이지 수 구하기
}
=======
public MateBoardInsertDTO selectOne(int id);
        }
        >>>>>>>develop/version1
