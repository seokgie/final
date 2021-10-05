<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>

    <title>Final</title>
    <%-- 부트 스트랩 메타태그 --%>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%-- 부트 스트랩 아이콘 --%>
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
    <!-- 부트스트랩 css 추가 -->
    <%--<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">--%>
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
            crossorigin="anonymous">
    <%-- 공통 css --%>
    <link href="${path}/resources/css/common.css?var=2" rel="stylesheet">
</head>
<body>
<%-- 상단 로그인 추가 --%>
<c:if test="${sessionScope.loginId eq null}">
    <jsp:include page="../../../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../../../fix/loginNavbar.jsp"/>
</c:if>
<%-- 상단 메뉴바 --%>
<jsp:include page="../../../fix/menu.jsp"/>
<%-- 내용 넣으세요 --%>
<div class="container px-3">
    <div class="container px-5 mt-5 ">
        <!-- 사이드 바 메뉴-->
        <h2 class="fw-bold my-3">아이디찾기</h2>
        <hr/>
        <div class="container px-3 w-50 border my-4">
            <form action="${path}/member/idFind" method="post" class="my-4">
                <h2 class="fw-bold">가입한 아이디 확인</h2>
                <hr/>
                <div class="form mb-3 mt-3">
                    <div>아이디</div>
                    <c:forEach items="${list}" var="lists">
                        <h2 class="fw-bold">${lists}</h2>
                    </c:forEach>
                    <div class="text-center">
                        <a href="${path}" class="btn btn-warning">메인으로</a>
                        <a href="${path}/member/loginForm" class="btn btn-warning mx-2">로그인</a>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
</body>
</html>
