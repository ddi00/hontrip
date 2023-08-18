package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dao.MateCommentDAO;
import com.multi.hontrip.mate.dao.MateDAO;
import com.multi.hontrip.mate.dto.*;
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
    public List<MateBoardListDTO> list(MatePageDTO matePageDTO) {
        matePageDTO.setStartEnd(matePageDTO.getPage());
        return mateDAO.list(matePageDTO);
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
    public MatePageDTO paging(MatePageDTO matePageDTO){
        //게시물 개수 가져오기
        int count = mateDAO.count(matePageDTO);
        matePageDTO.setCount(count);
        int currentPageNo = matePageDTO.getPage();
        //start, end지점 구하기
        matePageDTO.setStartEnd(currentPageNo);
        //페이징 마지막 숫자 구하기
        matePageDTO.setRealEndNo();
        //페이지 리스트의 첫 페이지 번호,마지막 페이지 번호 구하기
        matePageDTO.setFirstLast(currentPageNo);
        //다음 버튼 존재 여부 구하기
        matePageDTO.setNext();
        //이전 버튼 존재 여부 구하기
        matePageDTO.setPrev();
        //1page당 5개의 게시물을 넣는 경우
        //페이지 수 게산
        matePageDTO.setPages(count);
        return matePageDTO;
    }

    @Override
    public List<LocationDTO> location() {
        return mateDAO.location();
    }

    public List<MateCommentDTO> commentList(long mateBoardId){
        return mateCommentDAO.list(mateBoardId);
    }
    @Override
    public void insert(MateBoardInsertDTO mateBoardInsertDTO) {
        mateDAO.mateBoardInsert(mateBoardInsertDTO);
    }
    @Override
    public MateBoardInsertDTO selectOne(int id) {
        return mateDAO.mateBoardSelectOne(id);
    }
    @Override
    public int commentInsert (MateCommentDTO mateCommentDTO){
        return mateCommentDAO.insert(mateCommentDTO);
    }

    @Override
    public void commentDelete(MateCommentDTO mateCommentDTO){
        mateCommentDAO.delete(mateCommentDTO);
    }
    public void commentEdit(MateCommentDTO mateCommentDTO){
        mateCommentDAO.edit(mateCommentDTO);
    }
}
