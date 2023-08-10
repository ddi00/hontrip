package com.multi.hontrip.mate.dto;

import lombok.Data;
import lombok.RequiredArgsConstructor;

import java.time.LocalDateTime;

@Data
@RequiredArgsConstructor
public class MateBoardInsertDTO {

	private long userId;
	private int regionId;
	private int ageRangeId;
	private String title;
	private String content;
	private String thumbnail;
	private String startDate;
	private String endDate;
	private int recruitNumber;
	private Gender gender;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
	private boolean isFinish;
}
