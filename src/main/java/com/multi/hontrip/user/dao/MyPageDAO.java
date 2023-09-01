package com.multi.hontrip.user.dao;

import com.multi.hontrip.user.dto.MyCitiesDTO;
import com.multi.hontrip.user.dto.MyRecordDTO;
import com.multi.hontrip.user.dto.PageConditionDTO;

import java.util.List;

public interface MyPageDAO {
    int getRecordTotalCountByUserId(PageConditionDTO pageConditionDTO);

    List<MyRecordDTO> getRecordListByUserIdAndPage(PageConditionDTO pageConditionDTO);

    List<MyCitiesDTO> getRecordCityByUserId(PageConditionDTO pageConditionDTO);
}
