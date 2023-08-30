<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<input hidden id="mateAlarmUserId" value="<c:out value="${sessionScope.id}"/>">
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
</head>
<body>
<div class="content-wrapper">
  <tiles:insertAttribute name="header"/>
  <section class="wrapper bg-light">
    <div class="container py-14 py-md-16">
      <div class="row gx-lg-8 gx-xl-12">
        <tiles:insertAttribute name="body"/>
        <tiles:insertAttribute name="side"/>
      </div>
    </div>
  </section>
</div>
<tiles:insertAttribute name="footer"/>
<div class="progress-wrap">
  <svg class="progress-circle svg-content" width="100%" height="100%" viewBox="-1 -1 102 102">
    <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98"/>
  </svg>
</div>
</body>
</html>
