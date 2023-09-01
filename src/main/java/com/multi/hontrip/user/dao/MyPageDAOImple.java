package com.multi.hontrip.user.dao;

import com.multi.hontrip.user.dto.MyCitiesDTO;
import com.multi.hontrip.user.dto.MyRecordDTO;
import com.multi.hontrip.user.dto.PageConditionDTO;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class MyPageDAOImple implements MyPageDAO{

    private final SqlSessionTemplate sqlSessionTemplate;
    @Override
    public int getRecordTotalCountByUserId(PageConditionDTO pageConditionDTO) { //토탈 카운트
        return sqlSessionTemplate.selectOne("myPageMapper.getRecordTotalCountByUserId",pageConditionDTO);
    }

    @Override
    public List<MyRecordDTO> getRecordListByUserIdAndPage(PageConditionDTO pageConditionDTO) { //전체 페이징된 리스트
        return sqlSessionTemplate.selectList("myPageMapper.getRecordListByUserIdAndPage",pageConditionDTO);
    }

    @Override
    public List<MyCitiesDTO> getRecordCityByUserId(PageConditionDTO pageConditionDTO) { //내 도시
        return sqlSessionTemplate.selectList("myPageMapper.getRecordCityByUserId",pageConditionDTO);
    }

}
