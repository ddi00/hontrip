<%@ page import="com.multi.hontrip.mate.dto.Gender" %>
<%@ page import="com.multi.hontrip.mate.dto.Region" %>
<%@ page import="com.multi.hontrip.mate.dto.AgeRange" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("id") != null) {
        long userId = (long) session.getAttribute("id");
        request.setAttribute("user", userId);
    }
%>

<section class="wrapper image-wrapper bg-image bg-overlay bg-overlay-light-600 text-white"
         data-image-src="<c:url value='/resources/assets/img/photos/datachef_gradation.png'/>"
         style="background-image: url('<c:url value='/resources/assets/img/photos/bg13.jpg'/>');">
    <div class="content-wrapper">
        <section class="wrapper bg-xs-none">
            <div class="container pt-12 pb-10 pt-md-15 pb-md-12">
                <!-- /.row -->
            </div>
            <!-- /.container -->
            <%-- </section>
             <!-- /section -->
             <section class="wrapper bg-xs-none">--%>
            <div class="container pb-14 pb-md-16">
                <div class="row">
                    <div class="col-lg-10 mx-auto">
                        <div class="blog single mt-n15">
                            <div class="card shadow-xl">
                                <div class="card-body">
                                    <div class="total">

                                        <%--TODO: 유저아이디 숨기기 + 유저아이디 받아오기--%>
                                        <%--<input hidden name="userId" value=<%= request.getAttribute("id")%>>--%>
                                        <input hidden id="userId" name="userId" value="${user}">
                                        <div class="mateRegion">
                                            <c:forEach items="${Region.values()}" var="region">
                                                <input type="radio" id="${region.regionStr}" value="${region}"
                                                       name="regionId" class="mateInput mateRadio"
                                                       checked><label
                                                    for="${region.regionStr}">${region.regionStr}</label></input>

                                            </c:forEach>
                                        </div>


                                        <div class="numDate">
                                                <span class="mateOption">여행 기간</span>
                                                <div class="mateDates1">
                                                    <input
                                                            id="mateStartDate"
                                                            name="startDate"
                                                            type="date"
                                                            class="mateDateInput mateInput"
                                                            required
                                                    >
                                                    -
                                                    <input
                                                            id="mateEndDate"
                                                            name="endDate"
                                                            type="date"
                                                            class="mateDateInput mateInput"
                                                            required
                                                    >
                                                </div>
                                            </div>
                                            <div id="mateDateEmptyWarning" class="mateBoardEmptyWarning">여행 기간을 선택하세요
                                            </div>

                                            <div class="wantCondition">
                                                <span class="mateOption">모집 조건 (성별)</span>
                                                <c:forEach items="${Gender.values()}" var="gender">

                                                <c:if test="${gender ne Gender.NONE}">
                                                    <input type="radio" id="${gender.genderStr}" value="${gender}"
                                                           name="gender" class="mateInput mateRadio"
                                                           checked><label
                                                        for="${gender.genderStr}">${gender.genderStr}</label></input>
                                                </c:if>
                                            </c:forEach>

                                                <span class="mateOption2">모집 인원</span>
                                                <select name="recruitNumber" class="recruitNum mateInput"
                                                        id="recruitNumber">
                                                    <option value="1" selected>1명</option>
                                                    <option value="2">2명</option>
                                                    <option value="3">3명</option>
                                                    <option value="4">4명</option>
                                                    <option value="5">5명</option>
                                                    <option value="6">6명</option>
                                                </select>
                                            </div>
                                            <div class="insertWantAgeRange">
                                                <span class="mateOption">모집 조건 (연령대)</span>
                                                <c:forEach items="${AgeRange.values()}" var="ageRange">
                                                <c:if test="${ageRange ne AgeRange.AGE_UNKNOWN}">
                                                    <c:if test="${ageRange.ageRangeStr eq '전연령'}">
                                                        <input type="checkbox" id="${ageRange}"
                                                               class="mateCheckBox mateInput"
                                                               value="${ageRange.ageRangeNum}"
                                                               name="age"
                                                               onclick="ageRangeChecked()" checked><label
                                                            for="${ageRange}">${ageRange.ageRangeStr}</label></input>
                                                    </c:if>
                                                    <c:if test="${ageRange.ageRangeStr ne '전연령'}">
                                                        <input type="checkbox" class="mateCheckBox mateInput"
                                                               id="${ageRange}"
                                                               value="${ageRange.ageRangeNum}"
                                                               name="age"
                                                               onclick="ageRangeChecked()"><label
                                                            for="${ageRange}">${ageRange.ageRangeStr}</label></input>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                            </div>

                                            <input hidden id="ageRangeId" name="ageRangeId">
                                            <br>


                                            <div class="image-container">
                                                <div id="uploadYourImage" class="uploadYourImage">
                                                    여행지 사진을 업로드하세요
                                                </div>
                                                <img id="upldimg" src="" alt="Uploaded Image" width="100%"
                                                     height="250px" hidden>
                                                <input type="file" name="file" id="imageInput"
                                                       accept="image/jpeg, image/png, image/gif" required>
                                            </div>
                                            <div id="mateImageEmptyWarning" class="mateBoardEmptyWarning">여행지 이미지를
                                                업로드하세요
                                            </div>


                                            <div class="form-container">
                                                <input class="form-input form-input-title mateInput" type="text"
                                                       name="title" id="title"
                                                       placeholder="ex) 8/11 제주 월정리에서 같이 여행하실분 찾아요!!" required>
                                                <div id="mateTitleEmptyWarning" class="mateBoardEmptyWarning">제목을
                                                    입력하세요
                                                </div>
                                                <textarea id="content" class="form-input form-input-content mateInput"
                                                          name="content"
                                                          placeholder="같이 월정리 주변 여행하실분 계신가요? 사진찍는걸 좋아하고 바다 좋아하시는 분이었으면 좋겠어요"
                                                          rows="8" maxlength="500"
                                                          minlength="5" required></textarea>
                                                <div id="mateContentEmptyWarning" class="mateBoardEmptyWarning">내용을
                                                    입력하세요
                                                </div>
                                            </div>
                                            <input hidden name="isFinish" id="isFinish" value="0">

                                            <div class="mateButtons">
                                                <button id="cancel" onclick="location.href='bbs_list?page=1'"
                                                        class="btn btn-red mateButton">취소
                                                </button>
                                                <button id="complete" class="btn btn-yellow mateButton">작성완료</button>
                                            </div>
                                    </div>
                                </div>
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
            <!-- /.container -->
        </section>
        <!-- /section -->
    </div>
    <!-- /.content-wrapper -->
</section>