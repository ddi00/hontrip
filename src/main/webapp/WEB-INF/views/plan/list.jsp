<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<%
    long userId = 0;
    if (session.getAttribute("id") != null) {
        userId = (long) session.getAttribute("id");
        request.setAttribute("userId", userId);
    }
%>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75">
        <h3 class="mb-4">내 여행 일정</h3>
        <button type="button" class="btn btn-orange mb-3 w-100">
            <a href="create" role="button" class="text-white">새 일정 생성</a>
        </button>
        <c:forEach var="plan" items="${list}" varStatus="status">
            <div class="card mt-2">
                <div class="card-body my-2">
                    <div class="row">
                        <div class="col-md-11">
                            <h3><a href="detail?userId=${userId}&planId=${plan.planId}"
                                   class="custom-a">${plan.title}</a></h3>
                            <span>${plan.startDate} - ${plan.endDate}</span>
                            <span class="badge bg-pale-orange text-orange rounded-pill">${numOfDays[status.index]}일</span>
                            <br> <br>
                            <span style="font-size: .7rem; color: darkgray;"><fmt:formatDate value="${plan.createdAt}"
                                                                                             pattern="yyyy-MM-dd"
                                                                                             type="date"/> 작성</span>
                            <br>
                        </div>
                        <div class="col-md-1">
                            <button type="button" class="delete-plan-btn btn" data-plan-id="${plan.planId}" >
                                <svg style="color: red" xmlns="http://www.w3.org/2000/svg" width="16"
                                     height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                    <path
                                            d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"
                                            fill="red"></path>
                                    <path fill-rule="evenodd"
                                          d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"
                                          fill="red"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</section>
<script>
    let userId = <%= userId %>;
    // 일정 삭제 버튼 이벤트 처리
    $(document).on('click', '.delete-plan-btn', function () {
        let deleteButton = $(this);
        let planId = $(this).data("plan-id");
        $.ajax({
            method: "get",
            url: "delete",
            contentType: "application/json; charset=UTF-8",
            async: false,
            data: {
                userId: userId,
                planId: planId
            },
            success: function (result) {
                deleteButton.closest(".card").remove();
            },
            error: function () {
                alert("일정 삭제에 실패했습니다.");
            }
        });
    })
</script>