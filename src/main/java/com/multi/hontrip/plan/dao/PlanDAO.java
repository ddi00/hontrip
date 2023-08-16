package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.PlanDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

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

    public void delete(Long id) {
        my.delete("plan.delete", id);
    } // delete

    public PlanDTO one(Long id) {
        return my.selectOne("plan.one", id);
    }  // 일정 하나

    public List<PlanDTO> list() {
        return my.selectList("plan.all");
    }  // 일정 리스트(전체)


}
