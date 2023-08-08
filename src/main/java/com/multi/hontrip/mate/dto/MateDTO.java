package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class MateDTO {
	
	private long mateBoardId;
	private String title;
	private String content;
	private String thumbnale;
	private String startDate;
	private String finishDate;
	private boolean isFinish;
	private int recruitNumber;
	
}
