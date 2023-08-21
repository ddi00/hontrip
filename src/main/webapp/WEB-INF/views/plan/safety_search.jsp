<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form" %>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script>
    // 폼 제출 시 자바스크립트 함수 호출
    function submitForm() {
        // 수신지역 이름 입력란의 값을 가져옴
        var locationName = document.getElementById("locationName").value;
        // 한글을 인코딩
        var encodedLocationName = encodeURIComponent(locationName);
        // 결과 페이지로 이동
        window.location.href = "/hontrip/plan/safety_result?locationName=" + encodeURIComponent(locationName);
    }
</script>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75 text-center">
        <h1 class="mb-4">안전정보 조회</h1>
        <form class="mb-3">
            <div class="input-group">
                <input type="text" id="locationName" class="form-control" placeholder="수신지역 이름">
                <!-- custom-btn 클래스를 추가하여 배경색 적용 -->
                <button class="btn btn-yellow" type="button" onclick="submitForm()">조회</button>
            </div>
        </form>
    </div>
</section>