package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.PlanDAO;
import com.multi.hontrip.plan.dto.PlanDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlanServiceImpl implements PlanService{
    @Autowired
    PlanDAO planDAO;

    @Override
    public void insert(PlanDTO planDTO) {
        planDAO.insert(planDTO);
    }

    @Override
    public void update(PlanDTO planDTO) {
        planDAO.update(planDTO);
    }

    @Override
    public void delete(Long id) {
        planDAO.delete(id);
    }

    @Override
    public PlanDTO one(Long id) {
        return planDAO.one(id);
    }

    @Override
    public List<PlanDTO> list() {
        return planDAO.list();
    }
}