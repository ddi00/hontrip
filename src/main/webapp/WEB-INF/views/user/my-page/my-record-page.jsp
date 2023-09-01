<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-10 order-lg-2">
    <div class="blog single">
        <div class="card">
            <div class="card-body">
                <div class="row">
                    <div class="col-lg-4"> <!--제목 영역 -->
                        <h2 class="mb-5"><span class="main-color"><c:out value="${sessionScope.nickName}"/></span>님의
                            여행기록</h2>
                    </div>
                    <div class="col-lg-8 d-flex">


                    </div>
                </div>
                <div>
                    <c:forEach items="${cityMap}" var="entry">
                        <a class="btn filter-btn" value="${entry.cityId}"><i class="uil uil-check ash"></i>${entry.city}</a>
                    </c:forEach>
                </div>
                <div class="row">
                    <div class="col-md-8">
                        <p>전체<span id="recordTotalCount" class=""> ${pageInfo.totalCount}</span>건</p>
                    </div>
                    <div class="col-md-2">
                        <div class="form-select-wrapper mb-4">
                            <select class="form-select" aria-label="Default select example" id="visible-select">
                                <option value="all" selected>전체</option>
                                <option value="public">공개</option>
                                <option value="private">비공개</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-select-wrapper mb-4">
                            <select class="form-select" aria-label="Default select example" id="sort-select">
                                <option value="recentWrite" selected>최신 작성순</option>
                                <option value="oldWrite">오래된 작성순</option>
                                <option value="comment">댓글 많은순</option>
                                <option value="like">좋아요 많은순</option>
                                <option value="viewCount">조회수 많은순</option>
                            </select>
                        </div>
                    </div>
                </div>
                <table class="table table-striped" id="userInfoTable">
                    <thead>
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">도시</th>
                        <th scope="col">타이틀</th>
                        <th scope="col">여행일</th>
                        <th scope="col">공유</th>
                        <th scope="col"><i class="uil uil-heart"></i></th>
                        <th scope="col">댓글</th>
                        <th scope="col">조회수</th>
                        <th scope="col">작성일</th>
                        <th scope="col">선택</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${myRecordList}" var="record">
                        <tr>
                            <td>${record.no}</td>
                            <td>${record.city}</td>
                            <td><a class="page-link page-link moveBtn main-color" aria-label="Next"
                                   onclick="window.open('/hontrip/record/postinfo?id=${record.boardId}','','')">${record.title}</a>
                            </td>
                            <td>${record.startDate}~${record.endDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${record.isVisible == 1}">공개</c:when>
                                    <c:otherwise>비공개</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${record.likeCount}</td>
                            <td>${record.cmtCount}</td>
                            <td>${record.viewCount}</td>
                            <td>${record.createdAt}</td>
                            <td><input class="form-check-input selectRow" type="checkbox" value="${record.boardId}" required></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
                <!-- /nav -->
                <nav class="d-flex" aria-label="pagination">
                    <ul class="pagination mb-0 mx-auto">
                        <c:if test="${pageInfo.page!=1}">
                            <li class="page-item">
                                <a class="page-link refreshPageBTN" aria-label="firstPage" data-page-number="1">
                                    <span aria-hidden="true"><i class="uil uil-left-arrow-to-left"></i></span>
                                </a>
                            </li>
                        </c:if>


                        <c:if test="${pageInfo.showPrev}">
                            <li class="page-item">
                                <a class="page-link refreshPageBTN" aria-label="Previous"
                                   data-page-number="${pageInfo.page-1}">
                                    <span aria-hidden="true"><i class="uil uil-arrow-left"></i></span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach begin="${pageInfo.beginPage}" end="${pageInfo.endPage}" var="pageNumber">
                            <li class="page-item">
                                <a class="page-link refreshPageBTN" data-page-number="${pageNumber}"
                                   <c:if test="${pageNumber == pageInfo.page}">class="active"</c:if>>
                                    <c:out value="${pageNumber}"/>
                                </a>
                            </li>
                        </c:forEach>
                        <c:if test="${pageInfo.showNext}">
                            <li class="page-item">
                                <a class="page-link refreshPageBTN" aria-label="Next"
                                   data-page-number="${pageInfo.page+1}">
                                    <span aria-hidden="true"><i class="uil uil-arrow-right"></i></span>
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${pageInfo.page!=pageInfo.totalPage}">
                            <li class="page-item">
                                <a class="page-link refreshPageBTN" aria-label="lastPage" data-page-number="${pageInfo.totalPage}">
                                    <span aria-hidden="true"><i class="uil uil-arrow-to-right"></i></span>
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