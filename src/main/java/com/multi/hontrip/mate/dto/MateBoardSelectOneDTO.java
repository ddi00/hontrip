package com.multi.hontrip.mate.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class MateBoardSelectOneDTO {

    private long id;            //동행인게시판 id
    private long userId;        //동행인게시판 작성자 id
    private Region regionId;    //여행지
    private String ageRangeId;    //원하는 동행인 연령대
    private String title;        // 게시판 제목
    private String content;        //게시판 내용
    private String thumbnail;    //게시판 여행지 썸네일
    private String startDate;    //여행시작일
    private String endDate;        //여행 마지막일
    private int recruitNumber;    //여행 동행 모집인원
    private Gender gender;        //원하는 동행인 성별
    private LocalDateTime createdAt;    //게시판 작성일
    private LocalDateTime updatedAt;    //게시판 수정일
    private int isFinish;            //모집 확정 여부
    private String userNickName;    //닉네임
    private String userProfileImage;    //프로필 이미지
    private AgeRange userAgeRange;        //연령대
    private Gender userGender;      //성별
}
