package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.SpotDAO;
import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.dto.SpotSearchDTO;
import com.multi.hontrip.plan.parser.SpotParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.List;

@Service
public class SpotService {

    private SpotDAO spotDAO;
    private SpotParser spotParser;

    @Autowired
    public SpotService(SpotDAO spotDAO, SpotParser spotParser){
        this.spotDAO = spotDAO;
        this.spotParser = spotParser;
    }

    public void insert(SpotDTO spotDTO) throws IOException, ParserConfigurationException, SAXException  {
        spotDAO.insert(spotDTO);
    }

    public void parseData(SpotSearchDTO spotSearchDTO) throws IOException, ParserConfigurationException, SAXException {
        List<SpotDTO> spotList = list(spotSearchDTO);
        if(spotList.isEmpty()) {
            List<SpotDTO> list = spotParser.parseData(spotSearchDTO.getAreaName());
            // DB 추가
            for (SpotDTO spotDTO : list) {
                spotDAO.insert(spotDTO);
            }
        }
    }

    public List<SpotDTO> list(SpotSearchDTO spotSearchDTO) {
        String areaName = spotSearchDTO.getAreaName();
        // DAO에 파라미터 넘김
        return spotDAO.list(areaName);
    }
}
