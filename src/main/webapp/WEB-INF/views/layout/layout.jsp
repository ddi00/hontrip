<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title><tiles:getAsString name="title"/></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="<c:url value="/resources/img/common/favicon1.png"/>">
    <link rel="stylesheet" href="<c:url value="/resources/assets/css/plugins.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/assets/css/style.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/mate.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/plan.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/user.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/chat.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/record.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/alarm.css"/>">

    <script type="text/javascript" src="<c:url value="/resources/assets/js/plugins.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/assets/js/theme.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/jquery-3.7.0.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/sockjs-0.3.4.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/stomp.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/chat.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/user.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/mate.js"/>" defer></script>
    <script type="text/javascript" src="<c:url value="/resources/js/pagination.js"/>" defer></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        let stompClient = null;
        $(document).ready(function () {
            if ('<c:out value="${sessionScope.id}"/>' != "") {
                connectStomp()
            }
        });

        //웹소켓 연결 + 알림을 받기 위해 자신의 아이디를 구독
        function connectStomp() {
            let socket = new SockJS('${pageContext.request.contextPath}/matews');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                stompClient.subscribe('/sub/<c:out value="${sessionScope.id}"/>', function (result) {
                    applyAlarm(JSON.parse(result.body));
                })
            })
        }

        //stomp 설정 끊음
        function stompDisconnect() {
            if (stompClient != null) {
                stompClient.disconnect();
            }
        }

        //실시간 알림 삭제
        function deleteRealTimeAlarm(ths) {
            let deleteA = $(ths);
            deleteA.parents("li").remove();
        }


        //동행인 신청을 받으면 하단에 실시간 알림이 6초간 지속된 후 소멸함
        //알람리스트에도 알람이 추가됨
        function applyAlarm(result) {
            document.getElementById("myMateRealTimeAlarmModal").style.display = "block";
            if (document.getElementById("mateRealTimeAlarmUl").childElementCount >= 5) {
                document.getElementById("mateRealTimeAlarmUl").firstChild.remove();
            }
            $('#mateRealTimeAlarmUl').append("<li class='mateRealTimeAlarmLi' style='width: 95%;'>" + result.senderNickname + "님이 동행을 신청했어요!<span onclick='deleteRealTimeAlarm(this)'>x</span> </li>");
            document.getElementsByClassName("mateAlarmListClose")[0].addEventListener("click", function () {
                document.getElementById("myMateRealTimeAlarmModal").style.display = "none";
            });
            setTimeout(function () {
                document.getElementById("mateRealTimeAlarmUl").lastChild.remove();
            }, 3000);
        }

        //알람리스트에서 알람을 삭제하면 다시 페이지를 불러옴
        function mateAlarmOneDelete(element) {
            $('#mateAlarm' + element.getAttribute('data-id')).remove();
            $.ajax({
                url: "${pageContext.request.contextPath}/mate/delete_alarm",
                data: {
                    alarmId: element.getAttribute('data-id')
                },
                success: function (result) {
                },
                error: function (e) {
                    console.log(e);
                }
            })
            let current = element.id.substring(element.id.length - 1)
            alarmPageClick(current, 5, 5)
        }

        //알림 개수 표시 -> 헤더 append에 문제가 있어서 사용 보류
        function alarmCountPrint(totalCount) {
            if (totalCount == 0) {
                $('#alarmCount').hide();
            }

            if (totalCount >= 1 && totalCount < 10) {
                $('#alarmCount').text(totalCount);
                $('#alarmCount').show();
            }

            if (totalCount >= 10) {
                $('#alarmCount').text('9+');
                $('#alarmCount').show();
            }
        }

        //헤더에 알람을 클릭하면 1페이지가 표시됨
        function clickAlarm() {
            alarmPageClick(1, 5, 5);
        }

        //현재페이지, 한 페이지당 알람개수, 한 화면당 페이지 개수를 입력하면 해당 페이지의 알람들이 출력됨
        function alarmPageClick(cPage, aPerPage, aPerPage) {
            let hasBefore = null;
            let hasAfter = null;
            let startPageNum = null;
            let endPageNum = null;
            $.ajax({
                url: "${pageContext.request.contextPath}/mate/alarm_page",
                data: {
                    currentPage: cPage,
                    alarmNumPerPage: aPerPage,
                    pageNumPerPagination: aPerPage
                },
                success: function (pagination) {
                    let pages = '<nav class="d-flex" aria-label="pagination" style="justify-content: center; margin-top:15px;"> <ul class="pagination pagination-alt mb-0">';
                    hasBefore = pagination.hasBefore;
                    hasAfter = pagination.hasAfter;
                    startPageNum = pagination.startPageNum;
                    endPageNum = pagination.endPageNum;
                    let totalAlarmCount = pagination.totalCount;


                    /*//알림개수표시
                    alarmCountPrint(totalAlarmCount);*/
                    if (hasBefore == true) {
                        pages +=
                            '<li class="page-item" style="width: 15px; height: 15px;"> <a class="page-link" style="width: 15px; height: 15px; font-size: 12px;"onclick="alarmPageClick(' + (startPageNum - 1) + ',5,5)" aria-label="Previous">' +
                            '<span aria-hidden="true"><i class="uil uil-arrow-left"></i></span>' + '</a></li>';
                    }

                    for (let i = startPageNum; i <= endPageNum; i++) {
                        pages += '<li class="page-item" id="mateAlarmPageClick' + i + '" style="width: 15px; height: 15px;"><a class="page-link"  style="width: 15px; height: 15px; font-size: 12px;" onclick="alarmPageClick(' + i + ',5,5)" >' + i + '</a></li>'
                    }
                    if (hasAfter == true) {
                        pages += '<li class="page-item" style="width: 15px; height: 15px;"><a class="page-link" style="width: 15px; height: 15px; font-size: 12px;" onclick="alarmPageClick(' + (endPageNum + 1) + ',5,5)" aria-label="Next">' +
                            '<span aria-hidden="true"><i class="uil uil-arrow-right"></i></span></a></li>';
                    }

                    pages += '</ul></nav>';
                    $.ajax({

                        url: '${pageContext.request.contextPath}/mate/alarm_list',
                        data: {
                            currentPage: cPage,
                            userId: $('#mateAlarmUserId').val(),
                            alarmNumPerPage: aPerPage
                        },
                        success: function (list) {
                            $('#notificationList').html('');
                            document.getElementById("myMateAlarmModal").style.display = "block";
                            document.getElementsByClassName("mateAlarmListClose")[0].addEventListener("click", function () {
                                document.getElementById("myMateAlarmModal").style.display = "none";
                            });
                            if (list.length == 0) {
                                $('#notificationList').append('<span style="font-size: 12px;">불러올 알람이 없습니다.</span>')
                            } else {
                                for (let i = 0; i < list.length; i++) {
                                    if (i == list.length - 1) {
                                        $('#notificationList').append('<li id="mateAlarm' + list[i].id + '" class="mateAlarmListLi" xmlns="http://www.w3.org/1999/html"><span style="font-weight: bold; font-size: 12px; width: 100%; "> ' + list[i].senderNickname + '님이 동행 신청을 했어요!</span><br><span class="spanAlarmList">' +
                                            '<img style="border-radius: 70%;" src="' +
                                            list[i].senderProfileImage + '" alt="신청자프로필이미지" width="30px;" height="30px;"> <span style="display:-webkit-box; white-space:normal; overflow: hidden;-webkit-line-clamp: 2; -webkit-box-orient: vertical;width:60%; height:40px; font-size: 13px; ">' +
                                            list[i].content + '</span><a href="#" style="width:8%;"><i class="uil uil-comments"></i></a>' +
                                            '<a id="mateAlarmCurrentPage' + pagination.currentPage + '"onclick="mateAlarmOneDelete(this)" href="#" style="width:8%;" data-id="' + list[i].id + '">x</a> </span></li>');
                                    } else {
                                        $('#notificationList').append('<li id="mateAlarm' + list[i].id + '"class="mateAlarmListLi" xmlns="http://www.w3.org/1999/html"><span style="font-weight: bold; font-size: 12px; width: 100%; "> ' + list[i].senderNickname + '님이 동행 신청을 했어요!</span><br><span class="spanAlarmList">' +
                                            '<img style="border-radius: 70%;" src="' +
                                            list[i].senderProfileImage + '" alt="신청자프로필이미지" width="30px;" height="30px;"> <span style="display:-webkit-box; white-space:normal; overflow: hidden;-webkit-line-clamp: 2; -webkit-box-orient: vertical;width:60%; height:40px; font-size: 13px; ">' +
                                            list[i].content + '</span><a href="#" style="width:8%;"><i class="uil uil-comments"></i></a>' +
                                            '<a id="mateAlarmCurrentPage' + pagination.currentPage + '" onclick="mateAlarmOneDelete(this)" href="#" style="width:8%;" data-id="' + list[i].id + '">x</a> </span> <hr style="margin:0px;"> </li>')
                                    }
                                }
                                $('#notificationList').append(pages);
                            }
                        }
                    })
                },
                error: function (e) {
                    console.log(e);
                }
            })
        }
    </script>
</head>
<body>
    <div class="content-wrapper">
        <tiles:insertAttribute name="header"/>
        <tiles:insertAttribute name="body"/>
    </div>

    <tiles:insertAttribute name="footer"/>
    <div class="progress-wrap">
        <svg class="progress-circle svg-content" width="100%" height="100%" viewBox="-1 -1 102 102">
            <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98"/>
        </svg>
    </div>
    <input type="hidden" id="mateAlarmUserId" value="<c:out value="${sessionScope.id}"/>">
</body>
</html>
