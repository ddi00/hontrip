package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.SpotDAO;
import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.dto.SpotSearchDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.List;

@Service
public class SpotService {

    @Autowired
    SpotDAO spotDAO;

    public void insert(SpotDTO spotDTO) throws IOException, ParserConfigurationException, SAXException  {
        spotDAO.insert(spotDTO);
    }

    public List<SpotDTO> list(SpotSearchDTO spotSearchDTO) {
        String areaName = spotSearchDTO.getAreaName();
        // DAO에 파라미터 넘김
        return spotDAO.list(areaName);
    }
}
