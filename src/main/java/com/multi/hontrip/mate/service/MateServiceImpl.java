package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dao.MateDAO;
import com.multi.hontrip.mate.dto.MateBoardInsertDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MateServiceImpl implements MateService {

    @Autowired
    MateDAO mateDAO;

    @Override
    public void insert(MateBoardInsertDTO mateBoardInsertDTO) {
        mateDAO.mateBoardinsert(mateBoardInsertDTO);
    }
}
