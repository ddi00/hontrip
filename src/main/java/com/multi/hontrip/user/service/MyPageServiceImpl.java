package com.multi.hontrip.user.service;

import com.multi.hontrip.user.dao.MyPageDAO;
import com.multi.hontrip.user.dto.MyCitiesDTO;
import com.multi.hontrip.user.dto.MyRecordDTO;
import com.multi.hontrip.user.dto.PageConditionDTO;
import com.multi.hontrip.user.dto.PageDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class MyPageServiceImpl implements MyPageService{

    private final MyPageDAO myPageDAO;

    public Map<String, Object> getMyPageResult(Long userId, PageConditionDTO pageConditionDTO) {
        Map<String,Object> result = new HashMap<>();
        // 전체 페이지 구해서 페이징
        pageConditionDTO.setUserId(userId);
        if(pageConditionDTO.getCities()!=null ) {
            pageConditionDTO.setCityList(pageConditionDTO.getCities());
        }
        int totalCount = myPageDAO.getRecordTotalCountByUserId(pageConditionDTO);
        PageDTO pageDTO = new PageDTO(totalCount,pageConditionDTO.getPage());
        result.put("pageInfo",pageDTO);

        //페이징한 결과 리스트 담기
        pageConditionDTO.setPageSize(pageDTO.getPageSize());
        pageConditionDTO.setOffset((pageDTO.getPage()-1)*pageDTO.getPageSize());
        List<MyRecordDTO> recordList = myPageDAO.getRecordListByUserIdAndPage(pageConditionDTO);
        result.put("myRecordList",recordList);

        // 내가 다녀온 도시 리스트(중복제거)
        List<MyCitiesDTO> cityMap = myPageDAO.getRecordCityByUserId(pageConditionDTO);
        result.put("cityMap",cityMap);
        return result;
    }
}

