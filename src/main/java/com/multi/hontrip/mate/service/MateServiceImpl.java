package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dao.MateCommentDAO;
import com.multi.hontrip.mate.dao.MateDAO;
import com.multi.hontrip.mate.dto.LocationDTO;
import com.multi.hontrip.mate.dto.MateBoardListDTO;
import com.multi.hontrip.mate.dto.MateCommentDTO;
import com.multi.hontrip.mate.dto.PageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MateServiceImpl implements MateService{
    @Autowired
    private MateDAO mateDAO;

    @Autowired
    private MateCommentDAO mateCommentDAO;

    @Override
    public List<MateBoardListDTO> list(PageDTO pageDTO) {
        pageDTO.setStartEnd(pageDTO.getPage());
        return mateDAO.list(pageDTO);
    }

    public MateBoardListDTO one(long mateBoardId){
        return mateDAO.one(mateBoardId);
    }
    @Override
    public int pages(int count) {
        int pages = 0;
        if(count % 10 == 0) {
            pages = count / 5; //120개 --> 12pages
        }else {
            pages = count / 5 + 1; //122개 --> 13pages
        }
        return pages;
    }

    @Override
    public PageDTO paging(PageDTO pageDTO){

        //게시물 개수 가져오기
        int count = mateDAO.count(pageDTO);
        pageDTO.setCount(count);
        int currentPageNo = pageDTO.getPage();
        //start, end지점 구하기
        pageDTO.setStartEnd(currentPageNo);
        //페이징 마지막 숫자 구하기
        pageDTO.setRealEndNo();
        //페이지 리스트의 첫 페이지 번호,마지막 페이지 번호 구하기
        pageDTO.setFirstLast(currentPageNo);
        //다음 버튼 존재 여부 구하기
        pageDTO.setNext();
        //이전 버튼 존재 여부 구하기
        pageDTO.setPrev();
        //1page당 5개의 게시물을 넣는 경우
        //페이지 수 게산
        pageDTO.setPages(count);

        return pageDTO;
    }

    @Override
    public List<LocationDTO> location() {
        return mateDAO.location();
    }

    public List<MateCommentDTO> commentList(long mateBoardId){
        return mateCommentDAO.list(mateBoardId);
    }

    public int commentInsert (MateCommentDTO mateCommentDTO){
        return mateCommentDAO.insert(mateCommentDTO);
    }
}
