package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class AlarmPageDTO {
    private long userId;    //유저아이디
    private int currentPage;    //현재 페이지
    private int startAlarmNum;  //시작 알람 번호
    private int endAlarmNum;    //마지막 알람 번호
    private int totalCount; //총 데이터 개수
    private int pageCount;  //화면에 나타낼 페이지 개수
    private int alarmNumPerPage;  //한 페이지당 나타낼 알림 개수


    public void setStartAlarmNum(int currentPage) {
        this.startAlarmNum = (currentPage - 1) * 5;
    }

    public void setEndAlarmNum(int currentPage, int alarmNumPerPage) {
        this.endAlarmNum = (currentPage - 1) * 5 + alarmNumPerPage;
    }
}
