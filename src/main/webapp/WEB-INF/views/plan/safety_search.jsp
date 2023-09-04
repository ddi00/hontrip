<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix='form' uri="http://www.springframework.org/tags/form"%>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75 text-center">
        <h1 class="mb-4">안전정보 조회</h1>
        <form id="safetySearchForm" action="safety_result" method="post" class="mb-3">
            <div class="input-group">
                <input type="text" id="locationName" name="locationName" class="form-control" placeholder="수신지역 이름">
                <button class="btn btn-primary" type="submit">조회</button>
            </div>
        </form>
    </div>

    <div class="loading-overlay d-none" style="position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(255,255,255,0.8); z-index: 9999; display: flex; align-items: center; justify-content: center;">
        <div class="spinner-border text-primary" style="width: 4rem; height: 4rem;"></div>
    </div>
</section>

<script>
    $(document).ready(function() {
        $('#safetySearchForm').on('submit', function() {
            $('.loading-overlay').removeClass('d-none');
        });
    });
</script>

