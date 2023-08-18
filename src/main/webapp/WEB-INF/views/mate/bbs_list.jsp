<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script type="text/javascript" src="../resources/js/jquery-3.7.0.js" ></script>
    <script>
$(function() {
  // 초기 페이지 로딩 시 페이지 버튼 생성
   generatePageButtons(${pageDTO.page}, ${pageDTO.pageSize}, ${pageDTO.firstPageNoOnPageList}, ${pageDTO.lastPageNoOnPageList}, ${pageDTO.realEnd});

   // 검색 버튼 클릭 시 페이지 버튼 생성 및 데이터 가져오기
    $('#searchBtn').click(function() {
      let searchType = $('select[name="searchType"]').val();
      let keyword = $('input[name="keyword"]').val();
  $.ajax({
        url: '/hontrip/mate/pagination',
        data: {
          page: 1, // 검색 시 첫 페이지로 초기화
          searchType: searchType,
          keyword: keyword
        },
         dataType:'json',
        success: function(data) {
        console.log(JSON.stringify(data), "data");
          let str='';
          for(let i = 0; i < data.list.length; i++){
          let one=data.list[i];
            str += `<tr>
                   <td><img src = "\${one.thumbnail}"></td>
                   	<td><a href="\${one.mateBoardId}">\${one.title}</a></td>
                   <td>\${one.nickname}</td>
                   <td>\${one.ageRange}</td>
                   <td>\${one.startDate}</td>
                   <td>\${one.endDate}</td>
                   </tr>`
          }
          //alert(str);
          $('#list-area').empty().html(str);
          // 페이지 버튼 다시 생성
          generatePageButtons(1, data.pageDTO.pageSize, data.pageDTO.firstPageNoOnPageList, data.pageDTO.lastPageNoOnPageList, data.pageDTO.realEnd);
        },
        error: function() {
          alert("실패");
        }
      });
    });

  $('.paging').on('click', '.pageBtn', function() {
    let page = $(this).data('page');

    // 현재 검색 조건 가져오기
    let searchType = $('select[name="searchType"]').val();
    let keyword = $('input[name="keyword"]').val();

    $.ajax({
      url: '/hontrip/mate/pagination',
      data: {
        page: page,
        searchType: searchType,
        keyword: keyword
      },
      dataType:'json',
      success: function(data) {
      console.log(JSON.stringify(data), "data");
         let str='';
                  for(let i = 0; i < data.list.length; i++){
                  let one=data.list[i];
                    str += `<tr>
                           <td><img src = "\${one.thumbnail}"></td>
                           	<td><a href="bbs_one?mateBoardId=\${one.mateBoardId}">\${one.title}</a></td>
                           <td>\${one.nickname}</td>
                           <td>\${one.ageRange}</td>
                           <td>\${one.startDate}</td>
                           <td>\${one.endDate}</td>
                           </tr>`
                  }
                  //alert(str);
                  $('#list-area').empty().html(str);

                  // 페이지 버튼 다시 생성
                  let pageSize = data.pageDTO.pageSize;
                  generatePageButtons(page, data.pageDTO.pageSize, data.pageDTO.firstPageNoOnPageList, data.pageDTO.lastPageNoOnPageList, data.pageDTO.realEnd);

                },
      error: function() {
        alert("실패");
      }
    });
  });
  function generatePageButtons(page, pageSize, firstPageNoOnPageList, lastPageNoOnPageList, realEnd) {
    let pagingHtml = "";
    console.log(pageSize, "pageSize")
    if (page > 1) {
      pagingHtml += '<button class="pageBtn prevBtn" data-page="' + (page - 1) + '"> < </button>';
    }

    let startPage = Math.max(1, Math.floor((page - 1) / pageSize) * pageSize + 1);
    console.log(startPage, "startPage")
    let endPage = Math.min(startPage + pageSize - 1, realEnd);
    console.log(endPage, "endPage")
    for (let i = startPage; i <= endPage; i++) {
      if (i === page) {
        pagingHtml += '<button class="pageBtn active" data-page="' + i + '">' + i + '</button>';
      } else {
        pagingHtml += '<button class="pageBtn" data-page="' + i + '">' + i + '</button>';
      }
    }

    if (page < realEnd) {
      pagingHtml += '<button class="pageBtn nextBtn" data-page="' + (page + 1) + '"> > </button>';
    }

    if (endPage < realEnd) {
      pagingHtml += '<button class="pageBtn skipBtn" data-page="' + (endPage + 1) + '">>></button>';
    }

    if (startPage > 1) {
      pagingHtml = '<button class="pageBtn skipBtn" data-page="' + (startPage - pageSize) + '"><<</button>' + pagingHtml;
    }

    $('.paging').empty().html(pagingHtml);
  }

});

 </script>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Latest compiled and minified CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Latest compiled JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>


<body style="background: pink;">
<div>
<select name = "location" size="1">
<option selected value="">지역 선택</option>
<c:forEach items="${location}" var="location">
<option> ${location.city} </option>
</c:forEach>
</div>
<div>
<form name = "mate_search" autocomplete = "off">
</select>
 <select name="searchType">
      <option value="title">제목</option>
         <option value="content">내용</option>
      <option value="title_content">제목+내용</option>
      <option value="nickname">작성자</option>
  </select>
<input type = "text" name="keyword" value=""></input>
<button id="searchBtn" class="btn btn-primary mr-2">검색</button>
</form>
</div>
<table class="table table-borderless">
<tr>
<td>이미지</td>
<td>제목</td>
<td>글쓴이</td>
<td>모집 희망 나이대</td>
<td>여행 시작일</td>
<td>여행 종료일</td>
</tr>
<tbody id = list-area>
<c:forEach items="${list}" var="one">
<tr>
<td><img src = "${one.thumbnail}"></td>
	<td><a href="<c:url value='/mate/bbs_one?mateBoardId=${one.mateBoardId}'/>">${one.title}</a></td>
<td>${one.nickname}</td>
<td>${one.ageRange}</td>
<td>${one.startDate}</td>
<td>${one.endDate}</td>
</tr>
</c:forEach>
</tbody>
</table>
<hr color = "blue">
<div class="paging">
  <button class="pageBtn prevBtn" data-page="${pageDTO.firstPageNoOnPageList - 1}">Prev</button>

  <c:set var="startPage" value="${pageDTO.firstPageNoOnPageList}" />
  <c:set var="endPage" value="${pageDTO.lastPageNoOnPageList}" />

  <c:forEach var="num" begin="${startPage}" end="${endPage}">
    <c:choose>
      <c:when test="${num == pageDTO.page}">
        <button class="pageBtn active" data-page="${num}">${num}</button>
      </c:when>
      <c:otherwise>
        <button class="pageBtn" data-page="${num}">${num}</button>
      </c:otherwise>
    </c:choose>
  </c:forEach>

  <button class="pageBtn nextBtn" data-page="${pageDTO.lastPageNoOnPageList + 1}">></button>
</div>
</body>
</html>