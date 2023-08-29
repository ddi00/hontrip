package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dao.MateCommentDAO;
import com.multi.hontrip.mate.dao.MateDAO;
import com.multi.hontrip.mate.dto.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class MateServiceImpl implements MateService {
    @Autowired
    private MateDAO mateDAO;

    @Autowired
    private MateCommentDAO mateCommentDAO;

    @Autowired
    private ServletContext servletContext;
    private String relativePath = "resources/img/mateImg/";

    @Override
    public List<MateBoardListDTO> list(MatePageDTO matePageDTO) {
        matePageDTO.setStartEnd(matePageDTO.getPage());
        return mateDAO.list(matePageDTO);
    }

    @Override
    public List<MateBoardListDTO> regionList(MatePageDTO matePageDTO){
        matePageDTO.setStartEnd(matePageDTO.getPage());
        return mateDAO.regionList(matePageDTO);
    }

    public MateBoardListDTO one(long mateBoardId) {
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
    public MatePageDTO paging(MatePageDTO matePageDTO) {
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

    public List<MateCommentDTO> commentList(long mateBoardId) {
        return mateCommentDAO.list(mateBoardId);
    }

    @Override
    public void insert(MultipartFile file, MateBoardInsertDTO mateBoardInsertDTO) {
        String savedFileName = file.getOriginalFilename();
        mateBoardInsertDTO.setThumbnail(savedFileName);
        String uploadPath = servletContext.getRealPath("/") + relativePath + savedFileName;
        File target = new File(uploadPath);
        try {
            file.transferTo(target);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        mateDAO.mateBoardInsert(mateBoardInsertDTO);
    }


    @Override
    public MateBoardSelectOneDTO selectOne(long id) {
        return mateDAO.mateBoardSelectOne(id);
    }

    @Override
    public int commentInsert(MateCommentDTO mateCommentDTO) {
        return mateCommentDAO.insert(mateCommentDTO);
    }

    @Override
    public void commentDelete(MateCommentDTO mateCommentDTO) {
        mateCommentDAO.delete(mateCommentDTO);
    }
    @Override
    public void commentEdit(MateCommentDTO mateCommentDTO) {
        mateCommentDAO.edit(mateCommentDTO);
    }
    @Override
    public int replyInsert (MateCommentDTO mateCommentDTO){
        return mateCommentDAO.replyInsert(mateCommentDTO);
    }
    @Override
    public List<MateCommentDTO> reCommentList(List<MateCommentDTO> commentList) {
        List<MateCommentDTO> reCommentList = new ArrayList<>();

        for (MateCommentDTO mateCommentDTO : commentList) {
            if ("1".equals(mateCommentDTO.getCommentSequence())) {
                reCommentList.add(mateCommentDTO);
            }
        }
        return reCommentList;
    }

    public int commentCount(long mateBoardId){
        return mateCommentDAO.commentCount(mateBoardId);
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


    //유저가 동행인 신청을 했는지 확인
    @Override
    public int checkApply(MateMatchingAlarmDTO mateMatchingAlarmDTO) {
        return mateDAO.checkApply(mateMatchingAlarmDTO);
    }
}
