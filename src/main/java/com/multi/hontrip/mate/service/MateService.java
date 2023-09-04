package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dto.*;
import com.multi.hontrip.record.dto.PostInfoDTO;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

public interface MateService {
    List<MateBoardListDTO> list(MatePageDTO pageDTO); //게시물 리스트 가져오기

    List<MateBoardListDTO> regionList(MatePageDTO pageDTO); //지역 검색 리스트 가져오기

    MateBoardListDTO one(long mateBoardId); //게시물 상세 가져오기
    MatePageDTO paging(MatePageDTO matePageDTO);//페이징하기
    List<LocationDTO> location(); //지역 리스트 가져오기

    int pages(int count); //전체 페이지 수 구하기

    List<MateCommentDTO> commentList(long mateBoardId); //게시물 상세의 댓글 목록 가져오기

    List<MateCommentDTO> reCommentList(List<MateCommentDTO> commentList); //게시물 상세의 답글 목록 가져오기

    int commentInsert (MateCommentDTO mateCommentDTO); //댓글 insert

    int replyInsert (MateCommentDTO mateCommentDTO); //답글 insert

    void commentDelete(MateCommentDTO mateCommentDTO); //댓글 delete

    void commentEdit(MateCommentDTO mateCommentDTO); //댓글 수정

    int commentCount(long mateBoardId); //댓글 수 가져오기

    public void insert(MultipartFile file, MateBoardInsertDTO mateBoardInsertDTO); //동행인 게시글 작성하기

    public MateBoardSelectOneDTO selectOne(long id);    //동행인 상세게시글 가져오기

    public int updateMateBoard(MultipartFile file, MateBoardInsertDTO mateBoardInsertDTO); //동행인 상세게시글 수정하기

    public int updateMateBoard(MateBoardInsertDTO mateBoardInsertDTO); //동행인 상세게시글 수정하기

    public int deleteMateBoard(long id); //동행인 게시글 삭제하기

    public UserGenderAgeDTO findUserGenderAgeById(long id);  //동행 신청자의 성별과 연령대 가져오기

    public int checkApply(MateMatchingAlarmDTO mateMatchingAlarmDTO); //동행인 게시글 신청여부 확인

    List<MateSenderDTO> senderList(long id);

    void incrementPostViews(long id);

    List<Map<String, Object>> getAgeRangeList();

    List<Map<String, Object>> getRegionList();

    List<Map<String, Object>> getgenderList();

    List<MateBoardListDTO> likeTopTen();
}