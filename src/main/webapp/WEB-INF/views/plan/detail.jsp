<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<section class="wrapper bg-light">
    <div class="container-fluid container mt-15 mb-20 w-75">
            <div class="card mt-2">
                <div class="card-body">
                    사용자 id : ${plan.userId} <br>
                    제목 : ${plan.title} <br>
                    시작일 : <fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd" type="date"/> <br>
                    종료일 : <fmt:formatDate value="${plan.endDate}" pattern="yyyy-MM-dd" type="date"/> <br>
                    메모 : ${plan.memo} <br>
                    생성일시 : <fmt:formatDate value="${plan.createdAt}" pattern="yyyy-MM-dd HH:mm" type="date"/> <br>
                    수정일시 : <fmt:formatDate value="${plan.updatedAt}" pattern="yyyy-MM-dd HH:mm" type="date"/> <br>
                    <br>
                    <button type="button" class="btn btn-outline-yellow">
                        <a href="update?id=${plan.id}" role="button">수정</a>
                    </button>
                    <button type="button" class="btn btn-custom1">
                        <a href="delete?id=${plan.id}" role="button" class="text-white">삭제</a>
                    </button>
                </div>
            </div>
        <button type="button" class="btn btn-yellow my-2">
            <a href="list" role="button" class="text-white">목록</a>
        </button>
    </div>
</section>