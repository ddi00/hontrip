package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.PlanDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class PlanDAO {

    @Autowired
    SqlSessionTemplate my;

    public void insert(PlanDTO planDTO) {
       my.insert("plan.insert", planDTO);
    } // insert

    public void update(PlanDTO planDTO) {
        my.update("plan.update", planDTO);
    } // update

    public void delete(Long planId, Long userId) {
        // HashMap 으로 parameter 전달 - Long 타입 전달 시 myBatis 오류 발생하여 map으로 전달
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("planId", planId);
        paramMap.put("userId", userId);
        my.delete("plan.delete", paramMap);
    } // delete

    public PlanDTO one(Long planId, Long userId) {
        // HashMap 으로 parameter 전달
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("planId", planId);
        paramMap.put("userId", userId);
        return my.selectOne("plan.one", paramMap);
    }  // 일정 하나

    public List<PlanDTO> list(Long userId) {
        // HashMap 으로 parameter 전달
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("userId", userId);
        return my.selectList("plan.all", paramMap);
    }  // 일정 리스트(전체)


}
