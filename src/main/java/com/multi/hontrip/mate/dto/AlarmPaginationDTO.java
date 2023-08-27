package com.multi.hontrip.mate.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AlarmPaginationDTO {
    private int totalCount; //총 알림 개수
    private int currentPage;    //현재페이지
    private int alarmNumPerPage;  //한 페이지당 나타낼 알림 개수
    private int pageNumPerPagination;   //화면에 출력할 페이지 개수
    private int startPageNum;   //시작 페이지 번호
    private int endPageNum; //마지막 페이지 번호
    private int pageGroup;
    private boolean hasBefore;
    private boolean hasAfter;

    public AlarmPaginationDTO() {

    }


    public void setOthers(int totalCount, int currentPage,
                          int alarmNumPerPage,
                          int pageNumPerPagination) {
        this.totalCount = totalCount;
        this.currentPage = currentPage;
        this.alarmNumPerPage = alarmNumPerPage;
        this.pageNumPerPagination = pageNumPerPagination;
        this.pageGroup = (int) Math.ceil((double) currentPage / pageNumPerPagination);
        this.startPageNum = (pageGroup - 1) * pageNumPerPagination + 1;
        if (pageGroup * pageNumPerPagination >= ((int) Math.ceil((double) totalCount / alarmNumPerPage))) {
            this.endPageNum = (int) Math.ceil((double) totalCount / alarmNumPerPage);
        } else {
            this.endPageNum = pageGroup * pageNumPerPagination;
        }
        if (pageGroup >= 2) {
            this.hasBefore = true;      //다음페이지 생성
        } else {
            this.hasBefore = false;     //다음페이지 생성x
        }
        if (endPageNum < (totalCount + alarmNumPerPage - 1) / alarmNumPerPage) {
            this.hasAfter = true;       //이전페이지 생성
        } else {
            this.hasAfter = false;  //이전페이지 생성x
        }
    }


    public void setPageGroup(int currentPage, int pageNumPerPagination) {
        this.pageGroup = (int) Math.ceil((double) currentPage / pageNumPerPagination);
    }

    public void setStartPageNum(int pageGroup, int pageNumPerPagination) {
        this.startPageNum = (pageGroup - 1) * pageNumPerPagination + 1;
    }

    public void setEndPageNum(int totalCount, int pageGroup, int alarmNumPerPage, int pageNumPerPagination) {
        if (pageGroup * pageNumPerPagination >= ((int) Math.ceil((double) currentPage / pageNumPerPagination))) {
            this.endPageNum = (int) Math.ceil((double) currentPage / pageNumPerPagination);
        } else {
            this.endPageNum = pageGroup * pageNumPerPagination;
        }
    }

    public void setHasBefore(int pageGroup) {
        if (pageGroup >= 2) {
            this.hasBefore = true;
        } else {
            this.hasBefore = false;
        }
    }

    public void setHasAfter(int endPageNum, int totalCount, int alarmNumPerPage) {
        if (endPageNum < (totalCount + alarmNumPerPage - 1) / alarmNumPerPage) {
            this.hasAfter = true;
        } else {
            this.hasAfter = false;
        }
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getAlarmNumPerPage() {
        return alarmNumPerPage;
    }

    public void setAlarmNumPerPage(int alarmNumPerPage) {
        this.alarmNumPerPage = alarmNumPerPage;
    }

    public int getPageNumPerPagination() {
        return pageNumPerPagination;
    }

    public void setPageNumPerPagination(int pageNumPerPagination) {
        this.pageNumPerPagination = pageNumPerPagination;
    }

    public int getStartPageNum() {
        return startPageNum;
    }

    public void setStartPageNum(int startPageNum) {
        this.startPageNum = startPageNum;
    }

    public int getEndPageNum() {
        return endPageNum;
    }

    public void setEndPageNum(int endPageNum) {
        this.endPageNum = endPageNum;
    }

    public int getPageGroup() {
        return pageGroup;
    }

    public void setPageGroup(int pageGroup) {
        this.pageGroup = pageGroup;
    }

    public boolean isHasBefore() {
        return hasBefore;
    }

    public void setHasBefore(boolean hasBefore) {
        this.hasBefore = hasBefore;
    }

    public boolean isHasAfter() {
        return hasAfter;
    }

    public void setHasAfter(boolean hasAfter) {
        this.hasAfter = hasAfter;
    }
}
