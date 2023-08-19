package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.PlanDTO;
import com.multi.hontrip.plan.dto.PlanDayDTO;

import java.sql.Date;
import java.util.List;

public interface PlanDayService {

    void insert(Long planId, Date dayDate, String daySummary);
    List<PlanDayDTO> getByPlanId(Long planId);

}
