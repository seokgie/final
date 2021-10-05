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
    <link href="${path}/resources/css/bootstrap.css" rel="stylesheet">
    <%-- 공통 css --%>
    <link href="${path}/resources/css/common.css?var=3" rel="stylesheet">
    <style>
        a {
            text-decoration: none;
        }
    </style>
</head>
<body>
<%-- 상단 메뉴바 추가 --%>
<c:if test="${sessionScope.loginId eq null}">
    <jsp:include page="../../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../../fix/loginNavbar.jsp"/>
</c:if>
<jsp:include page="../../fix/menu.jsp"/>
<div class="row">
    <jsp:include page="../adminSidebar.jsp"/>
    <div class="col w-100 p-0">
        <div class="container px-3 my-2">
        <h3>게시글 상세보기</h3>
            <div class="col-md-9 mt-5 ">
            
            <table class="table text-center">
            <tr>
            	<th>아이디</th>
            	<td class='align-middle'>${detail.id}</td>
            </tr>
            <tr>
            	<th>제목</th>
            	<td class='align-middle'>${detail.title}</td>
            </tr>
            <tr>
            	<th>내용</th>
            	<td class='align-middle'>${detail.content}</td>
            </tr>
            <tr>
            	<th>블라인드 여부</th>
            	<td class='align-middle'>${detail.delCheck}</td>
            </tr>
            	
            </table>
            <div class="">
            <c:if test="${detail.delCheck=='N'}">
            <a class="btn btn-sm btn-dark" href='boardListBlack?boardNum=${detail.boardNum}&division=${detail.division}'>블라인드 처리</a>
            </c:if>
            <c:if test=""></c:if>
            
            <c:if test="${detail.delCheck=='Y'}">
            <a class="btn btn-sm btn-dark" href='boardListUnBlack?boardNum=${detail.boardNum}&division=${detail.division}'>블라인드 해제</a>
            </c:if>
            
            <a class="btn btn-sm btn-dark" href='./boardList' >리스트로</a>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<%-- 공통 js --%>
<script src="${path}/resources/js/common.js"></script>
</body>
<script>

</script>

</html>