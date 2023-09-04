<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript" src="../resources/js/jquery-3.7.0.js" ></script>

<!-- 피드 헤더 영역 -->
  <section class="feed-header">
    <section class="wrapper bg-light">
      <div class="container pt-11 pt-md-13 pb-10 pb-md-0 pb-lg-5 text-center">
        <div class="row">
          <div class="col-lg-8 col-xl-7 col-xxl-6 mx-auto" data-cues="slideInDown" data-group="page-title">
            <h1 class="display-1"><span class="underline-3 style-3 primary">여행기록</span> 공유</h1>
          </div>
        </div>
      </div>
    </section>
  </section>

  <!-- 버튼 영역 -->
    <section class="wrapper bg-light">
      <div class="container">
        <div class="row-record-buttons">
          <div class="col-lg-9-record-location-buttons col-xl-8 col-xxl-7 mx-auto">
            <button class="btn btn-orange rounded-pill mb-2 me-1 location-button" data-location="allLocations">전국</button>
            <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="capital-area">수도권</button>
            <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="gangwon">강원</button>
            <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="gyeongsang">경상</button>
            <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="jeolla">전라</button>
            <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="chungcheong">충청</button>
            <button class="btn btn-orange rounded-pill mb-3 me-3 location-button" data-location="jeju">제주</button>
          </div>
        </div>
      </div>
    </section>

    <section class="wrapper bg-light">
      <div class="container">
        <div class="row">
          <div class="col-lg-9-record-like-button col-xl-8 col-xxl-7 mx-auto">
            <button class="btn btn-lg btn-primary rounded-pill me-2 like-button" like="like">좋아요 순</button>
          </div>
        </div>
      </div>
    </section>

  <!-- 지역 버튼 선택 시 이벤트 처리 -->
    <script>
    $(document).ready(function() {
      $('.location-button').click(function() {
        // 초기화
        $("#feedlist_section").hide();
        $("#feedlist_button_like_section_result").hide();

        var selectedLocationId = $(this).data('location');
        var locationIdPattern = getPattern(selectedLocationId);
        var locationIdSpecialId = getSpecialId(selectedLocationId);
        var locationIdSpecialId2 = getSpecialId2(selectedLocationId);
        var locationIdSpecialId3 = getSpecialId3(selectedLocationId);

        // 서버로 AJAX 요청 보내기
        $.ajax({
          type: 'GET',
          url: "feedlist_location_buttons",
          data: {
            locationIdPattern: locationIdPattern,
            locationIdSpecialId: locationIdSpecialId,
            locationIdSpecialId2: locationIdSpecialId2,
            locationIdSpecialId3: locationIdSpecialId3
          },
          success: function(response) {
            $("#feedlist_location_buttons_section_result").html(response).show();
          },
          error: function() {
            alert('검색한 자료가 없습니다.');
          }
        });
      });
    });

    // 지역 버튼 권역 구분 작업
    function getPattern(selectedOption) {
      switch (selectedOption) {
        case "allLocations":
          return ""; // 전체 범위 설정
        case "capital-area":
          return "3%"; // 수도권 지역 범위 설정
        case "gangwon":
          return "2%"; // 강원 지역 범위 설정
        case "gyeongsang":
          return "4%"; // 경상 지역 범위 설정
        case "jeolla":
          return "5%"; // 전라 지역 범위 설정
        case "chungcheong":
          return "6%"; // 충청 지역 범위 설정
        case "jeju":
          return "9%"; // 제주지역(비여져있음 안되서 임의로 넣음)
        default:
          return ""; // 기본 값
      }
    }

    // 지역 버튼 권역 구분 작업 - 광역시 포함하는 작업1
    function getSpecialId(selectedOption) {
      switch (selectedOption) {
        case "capital-area":
          return "101";
        case "gyeongsang":
          return "102";
        case "jeolla":
          return "104";
        case "jeju":
          return "103";
        case "chungcheong":
          return "106";
        default:
          return "";
      }
    }

    // 지역 버튼 권역 구분 작업 - 광역시 포함하는 작업2
    function getSpecialId2(selectedOption) {
      switch (selectedOption) {
        case "gyeongsang":
          return "105";
        case "capital-area":
          return "109";
        case "chungcheong":
          return "107";
        default:
          return "";
      }
    }

    // 지역 버튼 권역 구분 작업 - 광역시 포함하는 작업3
    function getSpecialId3(selectedOption) {
      switch (selectedOption) {
        case "gyeongsang":
          return "108";
        default:
          return "";
      }
    }
  </script>

  <!-- 좋아요 버튼 선택 시 이벤트 처리 -->
    <script>
      $(document).ready(function() {
        $('.like-button').click(function() {
          // 초기화
          $("#feedlist_section").hide();
          $("#feedlist_location_buttons_section_result").hide();
          $.ajax({
            type: 'GET',
            url: "feedlist_like",
              success: function(response) {
                $("#feedlist_button_like_section_result").html(response).show();
              },
              error: function() {
                alert('검색한 자료가 없습니다.');
              }
            });
          });
        });
    </script>

    <!-- 게시물 스타일 -->
    <style>
         .project.item.col-md-6.col-xl-4.workshop .card-img-top {
             width: 100%;
             padding-bottom: 55%; /* 1:1 비율을 위해 높이를 너비와 동일하게 설정합니다. */
             position: relative;
             overflow: hidden; /* 이미지가 넘치지 않도록 설정합니다. */
         }

         .project.item.col-md-6.col-xl-4.workshop .card-img-top img {
             position: absolute;
             width: 100%;
             height: 100%;
             object-fit: cover; /* 이미지가 박스에 맞게 잘리지 않고 채워지도록 설정합니다. */
         }
        .txt_line {
              width:320px;
              padding:0 5px;
              overflow:hidden;
              text-overflow:ellipsis;
              white-space:nowrap;
          }
    </style>

  <!-- 공유피드 게시물 표시 부분 -->
    <div id="feedlist_section">
      <div class="container">
        <section class="wrapper bg-light">
          <div class="container py-10 py-md-3">
            <div class="row gy-6">
              <div class="row isotope gx-md-8 gy-8 mb-2">
                <c:forEach items="${feedlist}" var="postInfoDTO">
                   <div class="col-md-6 col-lg-4">
                     <article class="item post">
                       <div class="card">
                         <figure class="card-img-top overlay overlay-1 hover-scale">
                           <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                             <div class="mate-list-image-container">
                               <img src="<c:url value='/${postInfoDTO.thumbnail}'/>" alt=""/>
                             </div>
                             <span class="bg"></span>
                           </a>
                           <figcaption>
                             <h5 class="from-top mb-0">자세히 보기</h5>
                           </figcaption>
                         </figure>
                         <a href="/hontrip/record/postinfo?id=${postInfoDTO.boardId}">
                           <div class="card-body p-7">
                             <div class="post-header">
                               <div class="post-category mb-2 text-primary">${postInfoDTO.city}</div>
                               <h3 class="txt_line mb-0">${postInfoDTO.title}</h3>
                             </div>
                           </div>
                           <div class="card-footer">
                             <ul class="post-meta d-flex mb-0">
                               <li class="post-date"><i class="uil uil-calendar-alt"></i><span>${postInfoDTO.startDate}~${postInfoDTO.endDate}</span></li>
                               <li class="post-likes ms-auto"><i class="uil uil-heart-alt text-primary"></i>${postInfoDTO.likeCount}</li>
                             </ul>
                           </div>
                         </a>
                       </div>
                     </article>
                   </div>
                </c:forEach>
              </div>
            <div class="rePostList">
          </div>
        </section>
      </div>
    </div>

  <!-- 지역 버튼 선택 시 해당 지역 게시물 표시 부분 -->
    <div id="feedlist_location_buttons_section_result" ></div>

  <!-- 좋아요 버튼 선택 시 게시물 리스트 표시 부분 -->
    <div id="feedlist_button_like_section_result" ></div>

  <!-- 무한스크롤 이벤트 처리 -->
  <script>
    let currentPage = 1;
    let isLoading = false;
    let totalPageCount = "${totalPageCount}";

    $(window).on("scroll", function () {
      let scrollTop = $(window).scrollTop();
      let windowHeight = $(window).height();
      let documentHeight = $(document).height();
      let isBottom = scrollTop + windowHeight + 10 >= documentHeight;

      if (isBottom) {
        if (currentPage == totalPageCount || isLoading) {
          return;
        }
        isLoading = true;
        currentPage++;
        getPostList(currentPage);
      }
    });

    // 무한 스크롤 리스트 반환 메소드
    const getPostList = function (currentPage) {
      let pageNum = currentPage;
      $.ajax({
        method: "get",
        url: "re-post-page2",
        //contentType: "application/json; charset=UTF-8",
        data: {
          pageNum: pageNum,
        },
        success: function (result) {
           $(".rePostList").append(result);
           isLoading = false;
        },
        error: function () {
          alert("오류가 발생했습니다.");
        }
      });
    }
  </script>


