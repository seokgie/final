<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>

    <title>Final</title>
    <%-- 부트 스트랩 메타태그 --%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%-- 부트 스트랩 아이콘 --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <!-- 부트스트랩 css 추가 -->
    <%--<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <%-- 공통 css --%>
    <link href="${path}/resources/css/common.css?var=2" rel="stylesheet">
</head>
<body>
<%-- 상단 로그인 추가 --%>
<c:if test="${sessionScope.loginId eq null}">
    <jsp:include page="../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../fix/loginNavbar.jsp"/>
</c:if>
<%-- 상단 메뉴바 --%>
<jsp:include page="../fix/menu.jsp"/>
<%-- 내용 넣으세요 --%>
<div class="container px-3 my-3 border">
    캠핑장 전체 리스트
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
</body>
</html>
