package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class PageDTO {

	private int start;
	private int end;
	private int page;
	private int pages;
	private int count;
	private String searchType;
	private String keyword;

	public void setStartEnd(int page) {
		start = 1 + (page - 1) * 5;
		end = page * 5; //5의 배수
		// page --> start 	~ 	end
		// --------------------------
		//1page --> 1 		~ 	5
		//2page --> 6		~ 	10
		//3page --> 11		~ 	15
		//int onePage = 5;
		//(page * 5) - 4 ==> 1page --> 1
		//(2 * 5) - 4 ==> 2page --> 6
		//(3 * 5) - 4 ==> 3page --> 11
		//(page * onePage ) - page
	}


}
