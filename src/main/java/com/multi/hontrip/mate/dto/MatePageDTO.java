package com.multi.hontrip.mate.dto;

import lombok.Data;

@Data
public class MatePageDTO {
	//시작 데이터
	private int start;
	//종료 데이터
	private int end;
	//현재 페이지
	private int page;
	//전체 page 개수
	private int pages;
	//페이지 리스트에 게시되는 페이지 수
	private int pageSize = 5;
	//게시물 총 개수
	private int count;
	//한페이지당 게시되는 게시물 수
	private int recordCountPerPage = 5;
	//페이지 리스트의 첫 페이지 번호
	private int firstPageNoOnPageList;
	//페이지 리스트의 마지막 페이지 번호
	private int lastPageNoOnPageList;
	//페이징 마지막 숫자
	private int realEnd;
	//이전,다음버튼
	private boolean prev, next;
	//검색 타입
	private String searchType;
	//검색어
	private String keyword;

	public void setStartEnd(int page) {
		start = 5;
		end = (page - 1) * 5;
	}
	public void setRealEndNo(){
		realEnd = (int)(Math.ceil((count * 1.0) / recordCountPerPage));
	}
	public void setFirstLast(int page){
		realEnd = (int)(Math.ceil((count * 1.0) / recordCountPerPage));

		// 현재 페이지가 높은 범위에 속할 때, 범위를 수정하여 보여줄 페이지 수 조절
		if (realEnd < page + pageSize) {
			lastPageNoOnPageList = realEnd;
			firstPageNoOnPageList = Math.max(realEnd - pageSize + 1, 1);
		} else {
			lastPageNoOnPageList = (int)(Math.ceil(page / (double)pageSize)) * pageSize;
			firstPageNoOnPageList = lastPageNoOnPageList - (pageSize - 1);
		}
	}


	public void setPrev(){
		prev = firstPageNoOnPageList > 1;
	}

	public void setNext(){
		next = lastPageNoOnPageList < realEnd;
	}

	public int setPages(int count) {
		if (count % 10 == 0) {
			pages = count / 5; //120개 --> 12pages
		} else {
			pages = count / 5 + 1; //122개 --> 13pages
		}
		return pages;
	}
}
