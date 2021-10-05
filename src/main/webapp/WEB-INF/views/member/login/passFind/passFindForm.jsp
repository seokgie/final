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
    <jsp:include page="../../../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../../../fix/loginNavbar.jsp"/>
</c:if>
<%-- 상단 메뉴바 --%>
<jsp:include page="../../../fix/menu.jsp"/>
<%-- 내용 넣으세요 --%>
<div class="container px-3">
    <h2 class="fw-bold my-3">비밀번호 찾기</h2>
    <hr/>
    <div class="container px-3 w-50 border my-4">
        <form action="${path}/member/passFind" method="post" class="my-4">
            <h2 class="fw-bold">비밀번호 찾기</h2>
            <hr/>
            <div class="mb-3">
                <label for="id" class="form-label">아이디</label>
                <input name="id" type="text" class="form-control nullCheck" id="id" placeholder="필수정보 입니다">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <input name="email" type="text" class="form-control nullCheck" id="email" placeholder="필수정보 입니다">
            </div>
            <!--  비밀번호찾기 찾기 버튼 -->
            <div class="text-center mt-2">
                <input id="PwFindBtn" class="btn btn-warning" type="submit" value="비밀번호찾기">
            </div>
            <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                <symbol id="check-circle-fill" fill="currentColor" viewBox="0 0 16 16">
                    <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zm-3.97-3.03a.75.75 0 0 0-1.08.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-.01-1.05z"/>
                </symbol>
                <symbol id="info-fill" fill="currentColor" viewBox="0 0 16 16">
                    <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm.93-9.412-1 4.705c-.07.34.029.533.304.533.194 0 .487-.07.686-.246l-.088.416c-.287.346-.92.598-1.465.598-.703 0-1.002-.422-.808-1.319l.738-3.468c.064-.293.006-.399-.287-.47l-.451-.081.082-.381 2.29-.287zM8 5.5a1 1 0 1 1 0-2 1 1 0 0 1 0 2z"/>
                </symbol>
                <symbol id="exclamation-triangle-fill" fill="currentColor" viewBox="0 0 16 16">
                    <path d="M8.982 1.566a1.13 1.13 0 0 0-1.96 0L.165 13.233c-.457.778.091 1.767.98 1.767h13.713c.889 0 1.438-.99.98-1.767L8.982 1.566zM8 5c.535 0 .954.462.9.995l-.35 3.507a.552.552 0 0 1-1.1 0L7.1 5.995A.905.905 0 0 1 8 5zm.002 6a1 1 0 1 1 0 2 1 1 0 0 1 0-2z"/>
                </symbol>
            </svg>
            <c:if test="${suc eq false}">
                <div id="redalert"
                     class="alert alert-danger d-flex align-items-center mt-2"
                     role="alert">
                    <svg class="bi flex-shrink-0 me-2" width="24" height="24"
                         role="img" aria-label="Danger:">
                        <use xlink:href="#exclamation-triangle-fill"/>
                    </svg>
                    <div>정보가 틀립니다 다시 입력해주세요</div>
                </div>
            </c:if>
            <c:if test="${suc eq true}">
                <div class="alert alert-success d-flex align-items-center mt-2" role="alert">
                    <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:">
                        <use xlink:href="#check-circle-fill"/>
                    </svg>
                    <div>변경된 비밀번호가 메일로 전송되었습니다. <br/>변경된 비밀번호로 로그인 후 비밀번호를 변경해주세요!</div>
                </div>
            </c:if>
        </form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
</body>
</html>
