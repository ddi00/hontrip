package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.PlanDTO;
import com.multi.hontrip.plan.dto.PlanDayDTO;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class PlanDayDAO {
    @Autowired
    SqlSessionTemplate my;

    public void insert(PlanDayDTO planDayDTO) {
         my.insert("planday.insert", planDayDTO);
    }

    public List<PlanDayDTO> getByPlanId(Long planId) {
        return my.selectList("planday.getByPlanId", planId);
    }
}
