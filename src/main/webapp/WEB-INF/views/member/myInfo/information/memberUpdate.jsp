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
    <jsp:include page="../../../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../../../fix/loginNavbar.jsp"/>
</c:if>
<jsp:include page="../../../fix/menu.jsp"/>
<div class="row">
    <jsp:include page="../myInfoSidebar.jsp"/>
    <div class="col w-100 p-0">
        <div class="container px-3 my-2">
            <div class="pt-4 border-bottom border-dark">
                <h2 class="fw-bold">정보수정</h2>
            </div>
            <div class="d-flex justify-content-center my-2">
                <form action="${path}/myInfo/infoUpdate" class="w-50" method="post" id="updateForm">
                    <div class="mb-3">
                        <label for="id" class="form-label">아이디</label>
                        <input value="${dto.id}" name="id" type="text" class="form-control nullCheck" id="id"
                               placeholder="필수정보 입니다" disabled="disabled">
                    </div>
                    <div class="mb-3">
                        <label for="nickName" class="form-label">닉네임</label>
                        <input name="nickName" type="text" class="form-control nullCheck goCheck" id="nickName"
                               value="${dto.nickName}" placeholder="필수정보 입니다">
                        <div class="invalid-feedback"></div>
                    </div>
                    <div class="mb-3 text-center">
                        <input id="updateBtn" type="button" class="btn btn-warning" value="정보수정">
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<c:if test="${suc eq false}">
    <script>
        alert("닉네임을 반드시 입력해주세요");
    </script>
</c:if>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
<script>
    $('#updateBtn').on('click', function () {
        let nickName = $('#nickName').val();
        if (nickName == "") {
            alert("필수 정보 입니다");
        } else {
            $('#updateForm').submit();
        }
    })
</script>
</body>
</html>
