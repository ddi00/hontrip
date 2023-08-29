<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("id") != null) {
        long userId = (long) session.getAttribute("id");
        request.setAttribute("userId", userId);
    }
%>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75">
        <h2>여행 일정 생성</h2>
        <hr class="my-8"/>
        <form id="myForm" action="insert" method="post">
            <div class="mb-3">
                <label for="title" class="form-label">일정명</label>
                <input type="text" id="title" name="title" class="form-control" required>
            </div>
            <div class="row mb-3">
                <div class="col">
                    <label for="startDate" class="form-label">출발일</label>
                    <input type="date" id="startDate" name="startDate" class="form-control" required>
                </div>
                <div class="col">
                    <label for="endDate" class="form-label">종료일</label>
                    <input type="date" id="endDate" name="endDate" class="form-control" required>
                </div>
            </div>
            <div class="my-3">
                <label for="memo" class="form-label">메모</label>
                <textarea id="memo" name="memo" class="form-control h-20"></textarea>
            </div>
            <button type="submit" class="btn btn-orange my-5 w-100">생성하기</button>
        </form>
    </div>
</section>