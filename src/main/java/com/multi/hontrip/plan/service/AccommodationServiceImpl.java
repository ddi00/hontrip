package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.AccommodationDAO;
import com.multi.hontrip.plan.dto.AccommodationDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.List;

@Service
public class AccommodationServiceImpl implements AccommodationService{

    @Autowired
    AccommodationDAO accommodationDAO;

    @Override
    public AccommodationDTO one(Long accommodationId) {
        return accommodationDAO.one(accommodationId);
    } // 일정 하나만 보기
    @Override
    public List<AccommodationDTO> list() {
        return accommodationDAO.list();
    } // 일정 list
}
