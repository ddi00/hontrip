<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title><tiles:getAsString name="title"/></title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="<%= request.getContextPath() %>/resources/assets/img/favicon.png">
    <link rel="stylesheet" href="<c:url value="/resources/assets/css/plugins.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/assets/css/style.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/mate_board_insert.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/user.css"/>">
    <link rel="preload" href="<c:url value="/resources/assets/css/fonts/urbanist.css"/>"as="style" onload="this.rel='stylesheet'">
</head>
<body>
    <div class="content-wrapper">
          <tiles:insertAttribute name="header" />
          <tiles:insertAttribute name="body" />
    </div>
          <tiles:insertAttribute name="footer" />
    <div class="progress-wrap">
        <svg class="progress-circle svg-content" width="100%" height="100%" viewBox="-1 -1 102 102">
            <path d="M50,1 a49,49 0 0,1 0,98 a49,49 0 0,1 0,-98" />
        </svg>
    </div>
    <script src="<c:url value="/resources/assets/js/plugins.js"/>"/>
    <script src="<c:url value="/resources/assets/js/theme.js"/>"/>
</body>
</html>
