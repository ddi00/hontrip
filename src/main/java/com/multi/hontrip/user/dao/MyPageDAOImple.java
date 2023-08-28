package com.multi.hontrip.user.dao;

import com.multi.hontrip.user.dto.MyRecordDTO;
import com.multi.hontrip.user.dto.PageDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class MyPageDAOImple implements MyPageDAO{

    private final SqlSessionTemplate sqlSessionTemplate;
    @Override
    public int getTotalCountByUserId(Long userId, String dbName) {
        Map<String,Object> param = new HashMap<>();
        param.put("userId",userId);
        param.put("dbName",dbName);
        return sqlSessionTemplate.selectOne("myPageMapper.getTotalCountByUserId",param);
    }

    @Override
    public List<MyRecordDTO> getRecordListByUserIdAndPage(PageDTO pageDTO, Long userId) {
        int offset = (pageDTO.getPage()-1)*pageDTO.getPageSize();
        int pageSize = pageDTO.getPageSize();
        Map<String,Object> param = new HashMap<>();
        param.put("userId",userId);
        param.put("offset",offset);
        param.put("pageSize",pageSize);
        return sqlSessionTemplate.selectList("myPageMapper.getRecordListByUserIdAndPage",param);
    }
}
