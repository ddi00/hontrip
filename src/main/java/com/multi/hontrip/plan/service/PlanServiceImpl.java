package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.PlanDAO;
import com.multi.hontrip.plan.dto.PlanDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PlanServiceImpl implements PlanService{
    private PlanDAO planDAO;
    @Autowired
    public  PlanServiceImpl(PlanDAO planDAO){
        this.planDAO = planDAO;
    };

    @Override
    public Long insert(PlanDTO planDTO) {
        planDAO.insert(planDTO);
        return null;
    } // insert

    @Override
    public void update(PlanDTO planDTO) {
        planDAO.update(planDTO);
    } // update

    @Override
    public void delete(Long id) {
        planDAO.delete(id);
    } // delete

    @Override
    public PlanDTO one(Long id) {
        return planDAO.one(id);
    } // 일정 하나만 보기

    @Override
    public List<PlanDTO> list() {
        return planDAO.list();
    } // 일정 list
}
