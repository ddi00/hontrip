package com.multi.hontrip.plan.service;

import com.multi.hontrip.plan.dto.EmergencyFacilityDTO;
import com.multi.hontrip.plan.dao.EmergencyFacilityDAO;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
@PropertySource("classpath:properties/plan/kakaomapApi.properties")
public class EmergencyFacilityIdServiceImpl implements EmergencyFacilityService {
    @Autowired
    EmergencyFacilityDAO emergencyFacilityDAO;

    @Autowired
    private RestTemplate restTemplate;

    @Value("${kakao.map.api.key}")
    private String KAKAO_MAP_API_KEY;
    @Override
    @Async
    public void fetchAndSaveEmergencyFacilityData(String x, String y, int radius) {


        // 약국과 병원 카테고리 코드
        String categoryCodePharmacy = "PM9";
        String categoryCodeHospital = "HP8";

        List<EmergencyFacilityDTO> combinedResults = new ArrayList<>();

        // 약국 정보 요청
        combinedResults.addAll(fetchFromKakaoAPI(KAKAO_MAP_API_KEY, categoryCodePharmacy, x, y, radius));

        // 병원 정보 요청
        combinedResults.addAll(fetchFromKakaoAPI(KAKAO_MAP_API_KEY, categoryCodeHospital, x, y, radius));

        // 데이터베이스에 저장
        for (EmergencyFacilityDTO dto : combinedResults) {
            emergencyFacilityDAO.save(dto);
        }
    }

    private List<EmergencyFacilityDTO> fetchFromKakaoAPI(String apiKey, String categoryCode, String x, String y, int radius) {
        String apiUrl = String.format("https://dapi.kakao.com/v2/local/search/category.json?category_group_code=%s&x=%s&y=%s&radius=%d", categoryCode, x, y, radius);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "KakaoAK " + apiKey);

        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<String> responseEntity = restTemplate.exchange(apiUrl, HttpMethod.GET, entity, String.class);

        JSONObject jsonResponse = new JSONObject(responseEntity.getBody());
        JSONArray documents = jsonResponse.getJSONArray("documents");

        List<EmergencyFacilityDTO> results = new ArrayList<>();
        for (int i = 0; i < documents.length(); i++) {
            JSONObject document = documents.getJSONObject(i);

            EmergencyFacilityDTO dto = new EmergencyFacilityDTO();
            dto.setId(document.getString("id"));
            dto.setPlaceName(document.getString("place_name"));
            dto.setCategoryName(document.optString("category_name", ""));

            // 특정 카테고리 이름은 저장에서 제외
            if (excludeCategories(dto.getCategoryName())) {
                continue;
            }

            dto.setCategoryGroupCode(document.getString("category_group_code"));
            dto.setCategoryGroupName(document.getString("category_group_name"));
            dto.setPhone(document.optString("phone", ""));
            dto.setAddressName(document.getString("address_name"));
            dto.setRoadAddressName(document.optString("road_address_name", ""));
            dto.setX(document.getString("x"));
            dto.setY(document.getString("y"));
            dto.setPlaceUrl(document.optString("place_url", ""));
            dto.setDistance(document.optString("distance", ""));

            results.add(dto);
        }
        return results;
    }

    private boolean excludeCategories(String categoryName) {
        List<String> excluded = Arrays.asList(
                "의료,건강 > 병원 > 노인,요양병원",
                "의료,건강 > 병원 > 한방병원",
                "의료,건강 > 병원 > 정신건강의학과",
                "의료,건강 > 병원 > 성형외과",
                "의료,건강 > 병원 > 피부과"
        );
        for (String exclude : excluded) {
            if (categoryName.startsWith(exclude)) {
                return true;
            }
        }
        return false;
    }

    @Override
    public EmergencyFacilityDTO one(Long emergencyFacilityId) { // 응급시설 하나만 보기
        return emergencyFacilityDAO.one(emergencyFacilityId);
    }
    @Override
    public List<EmergencyFacilityDTO> list() {
        return emergencyFacilityDAO.list();
    } // 응급시설 리스트

    @Override
    public List<EmergencyFacilityDTO> filterByCategory(String categoryGroupName) { // 응급시설 카테고리 필터 (병원|약국)
        return emergencyFacilityDAO.filterByCategory(categoryGroupName);
    }

    @Override
    public List<EmergencyFacilityDTO> filterByAddress(String addressName) { // 응급시설 주소 필터
        return emergencyFacilityDAO.filterByAddress(addressName);
    }

    @Override
    public List<EmergencyFacilityDTO> filterByCategoryAndAddress(String categoryGroupName, String addressName) { // 응급시설 주소|카테고리 필터
        return emergencyFacilityDAO.filterByCategoryAndAddress(categoryGroupName, addressName);
    }
}
