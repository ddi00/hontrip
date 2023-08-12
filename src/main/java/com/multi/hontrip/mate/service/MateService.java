package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dto.LocationDTO;
import com.multi.hontrip.mate.dto.MateBoardInsertDTO;
import com.multi.hontrip.mate.dto.MateBoardListDTO;
import com.multi.hontrip.mate.dto.PageDTO;

import java.util.List;

public interface MateService {

    public void insert(MateBoardInsertDTO mateBoardInsertDTO);

    public MateBoardInsertDTO selectOne(int id);

    List<MateBoardListDTO> list(PageDTO pageDTO); //게시물 리스트 가져오기

    int count(); //게시물 개수 가져오기

    List<LocationDTO> location(); //지역 리스트 가져오기

    public int pages(int count); //전체 페이지 수 구하기
}
