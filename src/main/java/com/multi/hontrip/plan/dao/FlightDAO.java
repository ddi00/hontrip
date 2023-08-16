package com.multi.hontrip.plan.dao;

import com.multi.hontrip.plan.dto.FlightDTO;
import org.apache.ibatis.annotations.Param;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class FlightDAO {

    @Autowired
    SqlSessionTemplate my;

    public void insert(FlightDTO flightDTO){
        my.insert("flight.insert", flightDTO);
    }

    public List<FlightDTO> list(@Param("depAirportName") String depAirportName,
                                @Param("arrAirportName") String arrAirportName,
                                @Param("depDate") Date depDate) {
        // HashMap 통해 다중 parameter 전달
        Map<String, Object> paramMap = new HashMap<String, Object>();
        paramMap.put("depAirportName", depAirportName);
        paramMap.put("arrAirportName", arrAirportName);
        
        // Date 타입 depDate -> yyyy-MM-dd 형식 String 포맷팅
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String departure_date = format.format(depDate);
        paramMap.put("depDate", departure_date);

        return my.selectList("flight.list", paramMap);
    }
}
