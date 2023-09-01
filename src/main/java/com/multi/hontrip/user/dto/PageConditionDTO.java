package com.multi.hontrip.user.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Data
public class PageConditionDTO {
    private Long userId;    // 회원 아이디
    private int page=1;       // 요청페이지
    private int offset;     // 페이징 offset
    private int pageSize;   //페이지 사이즈
    private String keyword; //정렬 키워드
    private String isVisible="all";  //공유 여부
    private String cities;  //도시 필터값
    private List<Integer> cityList=null;

    public void setCityList(String cities) {    // 도시 리스트처리
        if(!cities.equals("null")) {
            this.cityList = Arrays.stream(cities.split(","))
                    .map(Integer::parseInt)
                    .collect(Collectors.toList());
        }
    }
}
