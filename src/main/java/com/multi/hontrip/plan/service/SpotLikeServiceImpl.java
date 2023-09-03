package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dao.SpotDAO;
import com.multi.hontrip.plan.dao.SpotLikeDAO;
import com.multi.hontrip.plan.dto.SpotDTO;
import com.multi.hontrip.plan.dto.SpotLikeDTO;
import com.multi.hontrip.plan.dto.SpotSearchDTO;
import com.multi.hontrip.plan.parser.SpotParser;
import com.mysql.cj.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class SpotLikeServiceImpl implements SpotLikeService {
    private SpotLikeDAO spotLikeDAO;

    @Autowired
    public SpotLikeServiceImpl(SpotLikeDAO spotLikeDAO) {
        this.spotLikeDAO = spotLikeDAO;
    }

    // 여행지 즐겨찾기 추가
    public void addSpotLike(SpotLikeDTO spotLikeDTO){
        spotLikeDAO.insertSpotLike(spotLikeDTO);
    }

    // 여행지 즐겨찾기 해제
    public void removeSpotLike(SpotLikeDTO spotLikeDTO){
        spotLikeDAO.deleteSpotLike(spotLikeDTO);
    }

    // 여행지 즐겨찾기 수 카운트
    public int countSpotLike(String spotContentId){
        int spotLikeCount = spotLikeDAO.countSpotLike(spotContentId);
        return spotLikeCount;
    }

    // 사용자가 즐겨찾기 한 여행지 조회
    public List<SpotLikeDTO> listUserLikedSpot(long userId){
        List<SpotLikeDTO> userLikedSpotList = spotLikeDAO.listUserLikedSpot(userId);
        return userLikedSpotList;
    }

    // 사용자가 즐겨찾기 한 여행지 id만 반환
    public List<String> listUserLikedSpotId(long userId){
        List<String> userLikedSpotIdList = spotLikeDAO.listUserLikedSpotId(userId);
        return userLikedSpotIdList;
    }

    // 여행지 상세 조회 시 사용자 즐겨찾기 여부 확인
    public int checkUserLiked(long userId, String spotContentId){
        SpotLikeDTO spotLikeDTO = new SpotLikeDTO();
        spotLikeDTO.setUserId(userId);
        spotLikeDTO.setSpotContentId(spotContentId);
        return spotLikeDAO.checkUserLiked(spotLikeDTO);
    }
}
