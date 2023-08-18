package com.multi.hontrip.mate.dto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class MateBoardInsertDTO {

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

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public Region getRegionId() {
		return regionId;
	}

	public void setRegionId(Region regionId) {
		this.regionId = regionId;
	}

	public String getAgeRangeId() {
		return ageRangeId;
	}

	public void setAgeRangeId(String ageRangeId) {
		this.ageRangeId = ageRangeId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getThumbnail() {
		return thumbnail;
	}

	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getRecruitNumber() {
		return recruitNumber;
	}

	public void setRecruitNumber(int recruitNumber) {
		this.recruitNumber = recruitNumber;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public LocalDateTime getCreatedAt() {
		/*return createdAt.format(DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm"));*/
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

	public int getIsFinish() {
		return isFinish;
	}

	public void setIsFinish(int isFinish) {
		this.isFinish = isFinish;
	}
}
