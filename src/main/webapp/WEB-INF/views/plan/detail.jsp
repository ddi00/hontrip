<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75">
            <div class="card mt-2">
                <div class="card-body">
                    사용자 id : ${plan.userId} <br>
                    일정명 : ${plan.title} <br>
                    출발일 : ${plan.startDate}<br>
                    종료일 : ${plan.endDate}<br>
                    메모 : ${plan.memo} <br>
                    생성일시 : <fmt:formatDate value="${plan.createdAt}" pattern="yyyy-MM-dd HH:mm" type="date"/> <br>
                    <br>
                    <button type="button" class="btn btn-outline-yellow">
                        <a href="update?planId=${plan.planId}" role="button">수정</a>
                    </button>
                    <button type="button" class="btn btn-custom1">
                        <a href="delete?planId=${plan.planId}" role="button" class="text-white">삭제</a>
                    </button>
                </div>
            </div>
        <button type="button" class="btn btn-orange my-2">
            <a href="list" role="button" class="text-white">목록</a>
        </button>
    </div>
</section>