<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form"%>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75 text-center">
        <h1 class="mb-4">안전정보 조회</h1>
        <form action="safety_result" method="post" class="mb-3">
            <div class="input-group">
                <input type="text" id="locationName" name="locationName" class="form-control" placeholder="수신지역 이름">
                <!-- custom-btn 클래스를 추가하여 배경색 적용 -->
                <button class="btn btn-yellow" type="submit">조회</button>
            </div>
        </form>
    </div>
</section>