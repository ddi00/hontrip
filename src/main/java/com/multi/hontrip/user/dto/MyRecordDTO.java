package com.multi.hontrip.user.dto;

import lombok.Data;

import java.text.SimpleDateFormat;
import java.util.Calendar;

@Data
public class MyRecordDTO {  // 내 목록에서 보여줄 기록 항목
    private int no;             // 번소(rowNum)
    private long boardId;       // 기록 포스트 id
    private int cityId;         // 도시 ID
    private String city;        // 도시명
    private String title;       // 제목
    private String thumbnail;   //썸네일
    private String createdAt;   // 생성일자
    private String updatedAt;   // 수정일자
    private String startDate;   // 여행 시작일
    private String endDate;     // 여행 종료일
    private int isVisible;      // 공개여부
    private int likeCount;      // 좋아요 카운트
    private int cmtCount;       // 코멘트 카운트
    private int viewCount;       // 조회수

    public MyRecordDTO() {    }
    public MyRecordDTO(int no, long boardId, int cityId, String city, String title, String thumbnail, String createdAt, String updatedAt, String startDate, String endDate, int isVisible, int likeCount, int cmtCount,int viewCount) {
        this.no = no;
        this.boardId = boardId;
        this.cityId = cityId;
        this.city = city;
        this.title = title;
        this.thumbnail = thumbnail;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.startDate = setDate(startDate);
        this.endDate = setDate(endDate);
        this.isVisible = isVisible;
        this.likeCount = likeCount;
        this.cmtCount = cmtCount;
        this.viewCount = viewCount;
    }
    private String setDate(String date) { // string으로 YYYY-MM-DD 형태로 들어옴 -> YY.MM.DD형태로 바꿔야 함
        //YYYY를 확인해서 올해면 MM.DD형태로 return
        try {
            // 주어진 문자열 날짜를 날짜 객체로 파싱
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(sdf.parse(date));

            // 현재 연도 가져오기
            int thisYear = Calendar.getInstance().get(Calendar.YEAR);

            // 주어진 날짜의 연도와 현재 연도 비교
            if (calendar.get(Calendar.YEAR) == thisYear) {
                // 같은 연도인 경우
                SimpleDateFormat outputFormat = new SimpleDateFormat("MM.dd");
                return outputFormat.format(calendar.getTime());
            } else {
                // 다른 연도인 경우
                SimpleDateFormat outputFormat = new SimpleDateFormat("yy.MM.dd");
                return outputFormat.format(calendar.getTime());
            }
        } catch (Exception e) {
            // 날짜 파싱 중 오류 발생한 경우
            e.printStackTrace();
            return ""; // 또는 오류 처리 로직을 추가할 수 있습니다.
        }
    }

    public void setStartDate(String startDate) {
        this.startDate = setDate(startDate);
    }

    public void setEndDate(String endDate) {
        this.endDate = setDate(endDate);
    }
}
