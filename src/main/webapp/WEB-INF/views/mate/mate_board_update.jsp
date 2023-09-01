<%@ page import="com.multi.hontrip.mate.dto.Gender" %>
<%@ page import="com.multi.hontrip.mate.dto.Region" %>
<%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
<%@ page import="com.multi.hontrip.mate.dto.MateBoardInsertDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% MateBoardInsertDTO dto = (MateBoardInsertDTO) request.getAttribute("dto");
    String contentBody = dto.getContent();
    request.setAttribute("contentBody", contentBody.replaceAll("<br>", "\n"));
%>

<%--<div class="content-wrapper">
    <section class="wrapper bg-xs-none">
        <div class="container pt-2 pb-10 pt-md-10 pb-md-10">
            <!-- /.row -->
        </div>
        <!-- /.container -->
    </section>
    <!-- /section -->--%>
<section class="container mateInsertContainer">
    <div class="mateInsertTitle">동행인 찾기</div>
    <hr style="margin:2% 0.8%; margin-bottom: 4%; color: rgba(0, 0, 0, 0.7);">
    <%--<div class="container pb-14 pb-md-16">
        <div class="row">
            <div class="col-lg-10 mx-auto">
                <div class="blog single mt-n15">
                    <div class="card shadow-xl">
                        <div class="card-body">--%>
    <div class="total">

        <%--js에서 사용하기 위해 설정--%>
        <input hidden id="mateBoardId" name="mateBoardId" value="${dto.id}">
        <input hidden id="mateBoardUserId" name="mateBoardUserId" value="${dto.userId}">
                                    <input hidden id="mateBoardThumbnail" name="mateBoardThumbnail"
                                           value="${dto.thumbnail}">
                                    <input hidden id="mateBoardDbAgeRangeId" name="mateBoardDbAgeRangeId"
                                           value="${dto.ageRangeId}">
                                    <input hidden id="mateBoardDbIsFinish" name="mateBoardDbIsFinish"
                                           value="${dto.isFinish}">
                                    <input hidden id="mateBoardDbRecruitNumber" name="mateBoardDbRecruitNumber"
                                           value="${dto.recruitNumber}">

                                        <div class="mateRegion">
                                            <c:forEach items="${Region.values()}" var="region">
                                            <c:if test="${dto.regionId eq region}">
                                                <input type="radio" id="${region.regionStr}" value="${region}"
                                                       name="regionId" class="mateInput mateRadio"
                                                       checked required><label
                                                    for="${region.regionStr}">${region.regionStr}</label></input>
                                            </c:if>
                                            <c:if test="${dto.regionId ne region}">
                                                <input type="radio" id="${region.regionStr}" value="${region}"
                                                       name="regionId" class="mateInput mateRadio" required
                                                ><label
                                                    for="${region.regionStr}">${region.regionStr}</label></input>
                                            </c:if>
                                        </c:forEach>
                                        </div>


                                        <div class="numDate">
                                            <span class="mateOption">여행 기간</span>
                                            <div class="mateDates2">
                                                <input
                                                        id="mateStartDate"
                                                        name="startDate"
                                                        type="date"
                                                        class="mateDateInput mateInput"
                                                        value="${dto.startDate}"
                                                        required
                                                >
                                                -
                                                <input
                                                        id="mateEndDate"
                                                        name="endDate"
                                                        type="date"
                                                        class="mateDateInput mateInput"
                                                        value="${dto.endDate}"
                                                        required
                                                >
                                            </div>

                                            <span class="mateOption2">모집확정여부</span>
                                            <select class="isFinish" name="isFinish" id="isFinish">
                                                <option value="0">모집중</option>
                                                <option value="1">모집완료</option>
                                            </select>
                                        </div>


                                        <div class="genderRecruitNum">
                                            <span class="mateOption">모집 조건 (성별)</span>

                                            <c:forEach items="${Gender.values()}" var="gender">
                                            <c:if test="${gender ne Gender.NONE}">
                                                <c:if test="${dto.gender eq  gender}">
                                                    <input type="radio" id="${gender.genderStr}" value="${gender}"
                                                           name="gender" onclick="genderChecked()"
                                                           class="mateInput mateRadio"
                                                           checked><label
                                                        for="${gender.genderStr}">${gender.genderStr}</label></input>
                                                </c:if>
                                                <c:if test="${dto.gender ne  gender}">
                                                    <input type="radio" id="${gender.genderStr}" value="${gender}"
                                                           onclick="genderChecked()" class="mateInput mateRadio"
                                                           name="gender"><label
                                                        for="${gender.genderStr}">${gender.genderStr}</label></input>
                                                </c:if>
                                            </c:if>
                                        </c:forEach>

                                            <span class="mateOption2">모집 인원</span>
                                            <select id="recruitNumber" name="recruitNumber" class="recruitNum"
                                                    value="${dto.recruitNumber}">
                                                <option value="1">1명</option>
                                                <option value="2">2명</option>
                                                <option value="3">3명</option>
                                                <option value="4">4명</option>
                                                <option value="5">5명</option>
                                                <option value="6">6명</option>
                                            </select>
                                        </div>

                                        <div class="wantAgeRange">
                                            <span class="mateOption">모집 조건 (연령대)</span>
                                            <c:forEach items="${AgeRange.values()}" var="ageRange">
                                            <c:if test="${ageRange ne AgeRange.AGE_UNKNOWN}">
                                                <input type="radio" id="${ageRange.ageRangeNum}"
                                                       class="mateCheckBox"
                                                       value="${ageRange.ageRangeNum}"
                                                       name="ageRangeId"
                                                       onclick="ageRangeChecked()"><label
                                                    for="${ageRange.ageRangeNum}">${ageRange.ageRangeStr}</label></input>
                                            </c:if>
                                        </c:forEach>
                                        </div>

                                        <%--<input hidden id="ageRangeId" name="ageRangeId">--%>
                                        <br>


                                        <div class="image-container">
                                            <img id="upldimg" src="../resources/img/mateImg/${dto.thumbnail}"
                                                 alt="Uploaded Image"
                                                 height="300px" width="100%">
                                            <input type="file" name="file" id="file" accept="image/*"
                                                   class="mateFileInput">
                                        </div>


        <div class="form-container">
            <input class="form-input form-input-title" type="text" id="title"
                   name="title"
                   value="${dto.title}" required>
                                            <textarea class="form-input form-input-content" id="content" name="content"
                                                      rows="8" required>${contentBody}</textarea>
                                        </div>


                                        <input hidden name="thumbnail" value="${dto.thumbnail}">
                                        <div class="mateButtons">
                                            <button id="cancel" onclick="location.href='bbs_list?page=1'"
                                                    class="btn btn-red mateButton">취소
                                            </button>
                                            <button id="edit" class="btn btn-yellow mateButton">수정완료</button>
                                        </div>
                                </div>
    <%--  </div>
      <!-- /.card-body -->
  </div>
  <!-- /.card -->
</div>
<!-- /.blog -->
</div>
<!-- /column -->
</div>
<!-- /.row -->
</div>
<!-- /.container -->--%>
    </section>
    <!-- /section -->
<%--</div>
<!-- /.content-wrapper -->--%>

