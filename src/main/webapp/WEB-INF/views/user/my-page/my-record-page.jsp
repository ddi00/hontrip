<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="col-lg-10 order-lg-2">
    <div class="blog single">
        <div class="card">
            <div class="card-body">
                <h2 class="mb-5"><c:out value="${sessionScope.nickName}" />님의 여행기록</h2>
                <table class="table table-striped" id="userInfoTable">
                    <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">도시</th>
                        <th scope="col">타이틀</th>
                        <th scope="col">여행시작일</th>
                        <th scope="col">여행종료일</th>
                        <th scope="col">작성일</th>
                        <th scope="col">공개여부</th>
                        <th scope="col">좋아요</th>
                        <th scope="col">코멘트</th>
                        <th scope="col">선택</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${myRecordList}" var="record">
                        <tr>
                            <td>${record.no}</td>
                            <td>${record.city}</td>
                            <td><a class="page-link page-link moveBtn main-color" aria-label="Next" onclick="window.open('/hontrip/record/postinfo?id=${record.boardId}','','')">${record.title}</a></td>
                            <td>${record.startDate}</td>
                            <td>${record.endDate}</td>
                            <td>${record.createdAt}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${record.isVisible == 1}">
                                        공개
                                    </c:when>
                                    <c:otherwise>
                                        비공개
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${record.likeCount}</td>
                            <td>${record.cmtCount}</td>
                            <td><input class="form-check-input selectRow" type="checkbox" value="${record.boardId}" required></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
               <!-- pagination -->
                <nav class="d-flex" aria-label="pagination">
                    <ul class="pagination mb-0 mx-auto">
                        <c:if test="${pageInfo.showPrev}">
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Previous" onclick="movePage('/hontrip/user/my-record/${pageInfo.page-1}')">
                                    <span aria-hidden="true"><i class="uil uil-arrow-left"></i></span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach begin="${pageInfo.beginPage}" end="${pageInfo.endPage}" var="pageNumber">
                            <li class="page-item">
                                <a class="page-link moveBtn" href="#" onclick="movePage('/hontrip/user/my-record/${pageNumber}')"><c:out value="${pageNumber}"/></a>
                            </li>
                        </c:forEach>
                        <c:if test="${pageInfo.showNext}">
                            <li class="page-item">
                                <a class="page-link" aria-label="Next" onclick="movePage('/hontrip/user/my-record/${pageInfo.page+1}')">
                                    <span aria-hidden="true"><i class="uil uil-arrow-right"></i></span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                    <!-- /.pagination -->
                </nav>
                <!-- /nav -->
            </div>
        </div>
        <!-- blog -->
    </div>
    <!-- col-lg-8-->
</div>