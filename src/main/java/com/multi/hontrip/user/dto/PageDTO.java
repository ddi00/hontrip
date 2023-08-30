package com.multi.hontrip.user.dto;

import lombok.Data;

@Data
public class PageDTO { // 마이페이지에서 paging할 DTO
    private int totalCount; // 총 게시물 개수
    private int pageSize=10;   // 한 페이지의 크기
    private int navSize = 5;    // 페이지 내비게이션의 크기
    private int totalPage; // 전체 페이지의 개수
    private int page;    // 현재 페이지
    private int beginPage;  // 내비게이션에서 첫페이지
    private int endPage;    // 내비게이션의 막페이지
    private boolean showPrev;   // 이전 페이지로 이동하는 링크를 보여줄 것인지 여부
    private boolean showNext;   // 다음 페이지로 이동하는 링크를 보여줄 것인지 여부

    public PageDTO(int totalCount) {
        this(totalCount,1);
    }

    public PageDTO(int totalCount, int page) {  //page생성자, 각 페이징 계산
        this.totalCount = totalCount;
        this.page = page;

        totalPage = (int)Math.ceil(totalCount/pageSize);
        calculateNavigation();  // beginPage와 endPage 구하기
        showPrev = beginPage !=1;
        showNext = endPage != totalPage;
    }

    private void calculateNavigation() {    //navi  계산
        int halfNav = navSize / 2;

        if (totalPage <= navSize) {
            beginPage = 1;
            endPage = totalPage;
        } else if (page <= halfNav) {
            beginPage = 1;
            endPage = navSize;
        } else if (page >= totalPage - halfNav) {
            beginPage = totalPage - navSize + 1;
            endPage = totalPage;
        } else {
            beginPage = page - halfNav;
            endPage = page + halfNav;
        }

        showPrev = page > 1;
        showNext = endPage < totalPage;
    }
}
