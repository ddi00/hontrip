<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<%
    long userId = 0;
    if (session.getAttribute("id") != null) {
        userId = (long) session.getAttribute("id");
        request.setAttribute("userId", userId);
    }
%>
<section class="wrapper bg-light">
    <div class="container-fluid container p-6 mt-13 mb-20 mx-auto w-75">
        <div class="row align-items-center my-5 position-relative zindex-1">
            <div class="col-md-9 col-xl-6 pe-xl-20" data-cues="slideInDown" data-group="page-title">
                    <h1 class="display-1">나의 <span class="underline-3 style-3 primary">여행 일정</span></h1>
            </div>
            <div class="col-md-3 col-xl-3 ms-md-auto mt-5 mt-md-0">
                <button type="button" class="btn btn-primary w-100">
                    <a href="create" role="button" class="text-white">새 일정 생성</a>
                </button>
            </div>
        </div>
        <div class="row justify-content-start">
        <c:forEach var="plan" items="${list}" varStatus="status">
            <div class="custom-card custom-col-for-plan mt-3 ms-3">
                <div class="card-body" style="padding: 1rem 1rem;">
                    <div class="row" style="height: 16px;">
                        <div class="col-12 text-end">
                            <button type="button" class="delete-plan-btn btn custom-btn-sm" data-plan-id="${plan.planId}">
                                <svg style="color: gray" xmlns="http://www.w3.org/2000/svg" width="16"
                                     height="16" fill="currentColor" class="bi bi-x" viewBox="0 0 16 16">
                                    <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708z"
                                          fill="gray"></path>
                                </svg>
                            </button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-10">
                            <h3><a href="detail?userId=${userId}&planId=${plan.planId}"
                                   class="custom-a">${plan.title}</a></h3>

                            <span><i class="uil uil-calendar-alt"></i> ${plan.startDate} - ${plan.endDate}</span>
                            <span class="badge bg-pale-orange text-orange rounded-pill">${numOfDays[status.index]}일</span>
                            <br> <br>
                            <span style="font-size: .7rem; color: darkgray;"><fmt:formatDate
                                    value="${plan.createdAt}"
                                    pattern="yyyy-MM-dd"
                                    type="date"/><i class="uil uil-edit-alt ms-1"></i></span>
                            <br>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        </div>
    </div>
</section>
<script>
    let userId = <%= userId %>;

    // 일정 삭제 버튼 이벤트 처리
    $(document).on('click', '.delete-plan-btn', function () {
        let deleteButton = $(this);
        let planId = $(this).data("plan-id");
        let checking = CheckBeforeDelete();
        if (checking == true){
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
                deleteButton.closest(".custom-card").remove();
            },
            error: function () {
                alert("일정 삭제에 실패했습니다.");
            }
        });
        }
    })

    function CheckBeforeDelete() {
        if (confirm("일정을 삭제하시겠습니까?") == true){
            return true;
        }else{
            return false;
        }
    }
</script>