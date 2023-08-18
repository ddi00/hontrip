package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dao.MateCommentDAO;
import com.multi.hontrip.mate.dao.MateDAO;
import com.multi.hontrip.mate.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MateServiceImpl implements MateService {

    @Autowired
    MateDAO mateDAO;

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
        if (count % 10 == 0) {
            pages = count / 5; //120개 --> 12pages
        } else {
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

    @Override
    public void insert(MateBoardInsertDTO mateBoardInsertDTO) {
        mateDAO.mateBoardInsert(mateBoardInsertDTO);
    }


    @Override
    public MateBoardSelectOneDTO selectOne(long id) {
        return mateDAO.mateBoardSelectOne(id);
    }

    @Override
    public int updateMateBoard(MateBoardInsertDTO mateBoardInsertDTO) {
        return mateDAO.updateMateBoard(mateBoardInsertDTO);
    }


    //동행인 상세게시글 삭제하기
    @Override
    public int deleteMateBoard(long id) {
        return mateDAO.deleteMateBoard(id);
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

    //유저가 동행인 신청을 했는지 확인
    @Override
    public int checkApply(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        return mateDAO.checkApply(mateMatchingAlarmDTO);
    }

}
