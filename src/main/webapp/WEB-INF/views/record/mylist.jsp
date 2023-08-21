<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
        <script type="text/javascript"
        	src="../resources/js/jquery-3.7.0.js" ></script>

</head>
<body>

<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e69993661da7de473afe445a95ada803"></script>
<script>

var mapContainer = document.getElementById('map'),
    mapOption = {
        center: new kakao.maps.LatLng(36.3504, 127.3845), // 지도의 중심 좌표
        level: 13 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도 생성

<c:forEach items="${mymap}" var="recordLocationDTO">
    var marker = new kakao.maps.Marker({ // 마커 생성
        map: map,
        position: new kakao.maps.LatLng(${recordLocationDTO.lat}, ${recordLocationDTO.lon}) // 마커 위치 설정
    });

    var infowindow = new kakao.maps.InfoWindow({
        content: '<div>id: ${recordLocationDTO.id}, city: ${recordLocationDTO.city}</div>' // 인포윈도우 내용 설정
    });

    // 마커 클릭 이벤트 등록
       kakao.maps.event.addListener(marker, 'click', function() {
           $.ajax({
               type: "GET", // 요청 메소드 (GET 또는 POST)
               url: "list-mylocation", // 요청할 URL
               data: { locationId: ${recordLocationDTO.id} }, // 마커의 locationId를 전달
               dataType: "html", // 응답 데이터 타입 (HTML로 가정)
               success: function(response) {
                $("#list-mylocation-result").html(response); // 응답 받은 HTML을 list-mylocation-result 영역에 추가
                $("#mylist-section").hide(); // mylist-section 숨기기
               },
               error: function() {
                   // 에러 처리
                   console.log("AJAX 요청 실패");
               }
           });
       });

       kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
       kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
   </c:forEach>

// 인포윈도우를 표시하는 클로저 생성 함수
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저 생성 함수
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}
</script>


<!-- 내 게시물 표시 부분 -->
<div id="mylist-section">
<a href="feedlist"><button>공유피드</button></a><br>
<a href="createpost"><button>게시글작성버튼</button></a><br>
내 게시물 전체 리스트 ( user_id : 1로 임의설정)
<hr color="red">
    <c:forEach items="${mylist}" var="createPostDTO">
                    유저정보 : ${createPostDTO.userId},
                    지역id : ${createPostDTO.locationId},
                    썸네일 : ${createPostDTO.thumbnail},
                    글제목 : ${createPostDTO.title},
                    공개여부: ${createPostDTO.isVisible} <br>
    </c:forEach>
</div>


<!-- 해당 지역 게시물 표시 부분 -->
<div id="list-mylocation-result" >

</div>

</body>
</html>
