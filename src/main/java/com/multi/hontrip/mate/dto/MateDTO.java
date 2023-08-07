package com.multi.hontrip.mate.dto;

public class MateDTO {
	
	private long mateBoardId;
	private String title;
	private String content;
	private String thumbnale;
	private String startDate;
	private String finishDate;
	private boolean isFinish;
	private int recruitNumber;
	
	public long getMateBoardId() {
		return mateBoardId;
	}
	public void setMateBoardId(long mateBoardId) {
		this.mateBoardId = mateBoardId;
	}
	public int getRecruitNumber() {
		return recruitNumber;
	}
	public void setRecruitNumber(int recruitNumber) {
		this.recruitNumber = recruitNumber;
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
	public String getThumbnale() {
		return thumbnale;
	}
	public void setThumbnale(String thumbnale) {
		this.thumbnale = thumbnale;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getFinishDate() {
		return finishDate;
	}
	public void setFinishDate(String finishDate) {
		this.finishDate = finishDate;
	}
	public boolean isFinish() {
		return isFinish;
	}
	public void setFinish(boolean isFinish) {
		this.isFinish = isFinish;
	}
	

	
}
