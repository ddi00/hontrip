package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dto.*;

import java.util.List;

public interface MateService {
    List<MateBoardListDTO> list(PageDTO pageDTO); //게시물 리스트 가져오기

    MateBoardListDTO one(long mateBoardId); //게시물 상세 가져오기
    PageDTO paging(PageDTO pageDTO);
    List<LocationDTO> location(); //지역 리스트 가져오기

    int pages(int count); //전체 페이지 수 구하기

    List<MateCommentDTO> commentList(long mateBoardId); //게시물 상세의 댓글 목록 가져오기

    int commentInsert (MateCommentDTO mateCommentDTO); //댓글 insert

    void commentDelete(MateCommentDTO mateCommentDTO); //댓글 delete

    void insert(MateBoardInsertDTO mateBoardInsertDTO);

    MateBoardInsertDTO selectOne(int id);

    void commentEdit(MateCommentDTO mateCommentDTO);
}