package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dao.MateDAO;
import com.multi.hontrip.mate.dto.LocationDTO;
import com.multi.hontrip.mate.dto.MateBoardInsertDTO;
import com.multi.hontrip.mate.dto.MateBoardListDTO;
import com.multi.hontrip.mate.dto.PageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MateServiceImpl implements MateService {

    @Autowired
    MateDAO mateDAO;

    @Override
    public void insert(MateBoardInsertDTO mateBoardInsertDTO) {
        mateDAO.mateBoardInsert(mateBoardInsertDTO);
    }


    @Override
    public MateBoardInsertDTO selectOne(int id) {
        return mateDAO.mateBoardSelectOne(id);
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

