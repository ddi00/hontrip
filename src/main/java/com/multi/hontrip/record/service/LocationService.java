package com.multi.hontrip.record.service;

import com.multi.hontrip.record.dao.LocationDAO;
import com.multi.hontrip.record.dto.LocationDTO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class LocationService {

    private final LocationDAO locationDAO;

    public List<LocationDTO> locationList() { // 위치 정보 db에서 가져오기
        return locationDAO.locationSelect();
    }
}
