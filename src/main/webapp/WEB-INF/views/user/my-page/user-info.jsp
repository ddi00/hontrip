<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-10 order-lg-2">
    <div class="blog single">
        <div class="card">
            <div class="card-body">
                <div class="d-flex flex-row d-flex align-items-center">
                    <div class="d-flex align-items-center">
                        <figure class="user-avatar" id="userProfileImage">
                            <img class="rounded-circle w-15" src="<c:url value="${userInfo.profileImage}"/>"
                                 alt="${userInfo.nickName}의 프로필 이미지">
                        </figure>
                        <div>
                            <h6 id="userNickName">${userInfo.nickName}</h6>
                            <span class="post-meta fs-15" id="userEmail">${userInfo.email}</span>
                        </div>
                        <!-- figure area -->
                    </div>
                    <div class="mt-3 mt-md-0 ms-auto">
                        <c:if test="${userInfo.provider eq 'kakao'}">
                            <a href="/hontrip/user/reaccept-terms"
                               class="btn btn-sm btn-soft-ash rounded-pill btn-icon btn-icon-start mb-0">
                                <i class="uil uil-file-check-alt"></i> 동의정보갱신
                            </a>
                        </c:if>
                        <a href="/hontrip/user/refresh-userInfo"
                           class="btn btn-sm btn-soft-ash rounded-pill btn-icon btn-icon-start mb-0"
                           id="refreshUserInfoButton">
                            <i class="uil uil-sync"></i> 회원정보갱신
                        </a>
                        <a href="/hontrip/user/withdraw"
                           class="btn btn-red btn-sm rounded-pill btn-icon btn-icon-start mb-0">
                            <i class="uil uil-desktop-slash"></i> 회원탈퇴
                        </a>
                        <!-- refresh button -->
                    </div>
                </div>
                <!-- card body -->
            </div>
            <div class="card-footer position-relative">
                <a class="collapse-link stretched-link" data-bs-toggle="collapse" href="#collapse-2">
                    회원정보 더 보기
                </a>
                <!-- more user Info -->
            </div>
            <div id="collapse-2" class="card-footer p-0 accordion-collapse collapse">
                <div class="card-body">
                    <div class="alert alert-warning alert-icon" role="alert" style="display: none" id="warningAlert">
                        <i class="uil uil-exclamation-triangle"></i>※ 정보 이용에 모두 동의하지 않으면 서비스를 정상적으로 이용할 수
                        없습니다.
                    </div>
                    <table class="table" id="userInfoTable">
                        <thead>
                        <tr>
                            <th scope="col">항목</th>
                            <th scope="col">정보</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>가입 소셜</td>
                            <td>${userInfo.provider}</td>
                        </tr>
                        <tr>
                            <td>이메일</td>
                            <td id="emailInfo">${userInfo.email}</td>
                        </tr>
                        <tr>
                            <td>닉네임</td>
                            <td id="nickNameInfo">${userInfo.nickName}</td>
                        </tr>
                        <tr>
                            <td>성별</td>
                            <td id="genderInfo">${userInfo.gender}</td>
                        </tr>
                        <tr>
                            <td>연령대</td>
                            <td id="ageRangeInfo">${userInfo.ageRange}</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- card -->
        </div>
        <!-- blog -->
    </div>
    <!-- col-lg-8-->
</div>

