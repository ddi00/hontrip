<%--
  Created by IntelliJ IDEA.
  User: ehska
  Date: 2023-09-04
  Time: 오후 3:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<div>동행인 페이지입니다.</div>--%>
<div class="col-lg-10 order-lg-2">
    <div class="blog single">
        <div class="card">
            <div class="card-body">
                안녕하세요!!!
            </div>
        </div>
    </div>
</div>

<%--
<div class="row gy-6">
  <div class="row isotope gx-md-8 gy-8 mb-8">
    <c:forEach items="${list}" var="one" varStatus="loop">
      <div class="col-md-6 col-lg-4">
        <article class="item post mate-post-item">
          <div class="card">
            <figure class="card-img-top overlay overlay-1 hover-scale">
              <a href="../mate/${one.mateBoardId}">
                <div class="mate-list-image-container">
                  <img src="<c:url value='/resources/img/mateImg/${one.thumbnail}'/>"
                       alt="Image">
                </div>
                <span class="bg"></span>
              </a>
              <figcaption>
                <h5 class="from-top mb-0">Read More</h5>
              </figcaption>
            </figure>

            <div class="card-body">
              <div class="post-header">
                <div class="post-header d-flex align-items-center mb-3"> <!-- 프로필 이미지와 닉네임을 가로로 나란히 배치 -->
                  <figure class="user-avatar">
                    <img class="rounded-circle" alt="" src="${one.profileImage}"/>
                  </figure>
                    ${one.nickname}
                </div>
                <h2 class="post-title h3 mt-1 mb-2">
                  <a class="link-dark mb-2"
                     href="../mate/${one.mateBoardId}">${one.title}</a><br><br>
                  <c:forEach items="${AgeRange.values()}" var="age">
                    <c:if test="${age.ageRangeNum == Integer.parseInt(one.ageRangeId)}">
                      <div class="badge bg-pale-primary text-primary rounded-pill">#${age.ageRangeStr}</div>
                    </c:if>
                  </c:forEach>
                  <c:forEach items="${Gender.values()}" var="gender">
                    <c:if test="${gender.genderNum == Integer.parseInt(one.genderId)}">
                      <div class="badge bg-pale-primary text-primary rounded-pill">#${gender.genderStr}</div>
                    </c:if>
                  </c:forEach>
                  <c:forEach items="${Region.values()}" var="Region">
                    <c:if test="${Region.regionNum == Integer.parseInt(one.regionId)}">
                      <div class="badge bg-pale-primary text-primary rounded-pill">#${Region.regionStr}</div>
                    </c:if>
                  </c:forEach>
                </h2>
                <ul class="post-meta d-flex mb-0 mate-list-one">
                  <li class="post-date"><i
                          class="uil uil-calendar-alt"></i><span>${one.startDate}
                  </span></li>
                  <li class="post-date"><i
                          class="uil uil-calendar-alt"></i><span>${one.endDate}</span>
                  </li>
                  <li class="post-likes ms-auto">
                    <i class="uil uil-user-check"></i>조회수${one.viewCount}</li>
                </ul>
                <!-- /.post-meta -->
              </div>
            </div>
          </div>
        </article>
      </div>
    </c:forEach>
  </div>
</div>

<nav class="d-flex mate-pagination" aria-label="pagination">
  <ul class="pagination">
    <c:set var="startPage" value="${pageDTO.firstPageNoOnPageList}"/>
    <c:set var="endPage" value="${pageDTO.lastPageNoOnPageList}"/>
    <li class="page-item disabled">
      <button class="page-link pageBtn prevBtn"
              data-page="${pageDTO.firstPageNoOnPageList - 1}"><i
              class="uil uil-arrow-left"></i></button>
    </li>
    <c:forEach var="num" begin="${startPage}" end="${endPage}">
      <c:choose>
        <c:when test="${num == pageDTO.page}">
          <li class="page-item active">
            <button class="page-link pageBtn active"
                    data-page="${num}">${num}</button>
          </li>
        </c:when>
        <c:otherwise>
          <li class="page-item">
            <button class="page-link pageBtn"
                    data-page="${num}">${num}</button>
          </li>
        </c:otherwise>
      </c:choose>
    </c:forEach>
    <c:choose>
      <c:when test="${pageDTO.pages > pageDTO.lastPageNoOnPageList}">
        <li class="page-item">
          <button class="page-link pageBtn nextBtn"
                  data-page="${pageDTO.lastPageNoOnPageList + 1}">
            <i class="uil uil-arrow-right"></i>
          </button>
        </li>
      </c:when>
      <c:otherwise>
        <li class="page-item disabled">
          <button class="page-link pageBtn nextBtn"
                  data-page="${pageDTO.lastPageNoOnPageList + 1}">
            <i class="uil uil-arrow-right"></i></button>
        </li>
      </c:otherwise>
    </c:choose>
  </ul>
  <!-- /.pagination -->
</nav>--%>
