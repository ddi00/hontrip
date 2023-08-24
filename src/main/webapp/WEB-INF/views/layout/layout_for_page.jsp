<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <script type="text/javascript" src="<c:url value="/resources/js/jquery-3.7.0.js"/>" defer></script>
</head>
<body>
<div class="content-wrapper">
  <tiles:insertAttribute name="body" />
</div>
</body>
</html>
