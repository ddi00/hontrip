package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.PlanDAO;
import com.multi.hontrip.plan.dao.PlanDayDAO;
import com.multi.hontrip.plan.dto.PlanDTO;
import com.multi.hontrip.plan.dto.PlanDayDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.List;

@Service
public class PlanDayServiceImpl implements PlanDayService{
    @Autowired
    PlanDayDAO planDayDAO;

    @Override
    public void insert(Long planId, Date day_date, String day_summary) {
        planDayDAO.insert(new PlanDayDTO(planId, day_date, day_summary));
    }

    @Override
    public List<PlanDayDTO> getByPlanId(Long planId) {
        return planDayDAO.getByPlanId(planId);
    }
}
