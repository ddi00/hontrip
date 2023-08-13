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

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getPages() {
		return pages;
	}

	public void setPages(int pages) {
		this.pages = pages;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
}
