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
                <form action="${path}/myInfo/passChange" class="w-50" method="post" id="updateForm">
                    <div class="mb-3">
                        <label for="pw" class="form-label">비밀번호</label>
                        <input name="pw" type="password" class="form-control nullCheck" id="pw"
                               placeholder="필수정보 입니다">
                        <div class="invalid-feedback">필수정보 입니다</div>
                    </div>
                    <div class="mb-3">
                        <label for="pwCheck" class="form-label">비밀번호확인</label>
                        <input name="pwCheck" type="password" class="form-control nullCheck" id="pwCheck"
                               placeholder="필수정보 입니다">
                        <div class="invalid-feedback">필수정보 입니다</div>
                    </div>
                    <div class="mb-3">
                        <label for="pwChange" class="form-label">변경할 비밀번호</label>
                        <input name="pwChange" type="password" class="form-control nullCheck" id="pwChange"
                               placeholder="필수정보 입니다">
                        <div class="invalid-feedback">필수정보 입니다</div>
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
        alert("정보가 틀립니다 다시 입력해주세요");
    </script>
</c:if>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
<script>
    $('#updateBtn').on('click', function () {
        let check = true;
        $('.nullCheck').each(function (index, el) {
            if ($(this).hasClass('is-valid')) {
                return true;
            } else {
                check = false;
                $(this).addClass('is-invalid');
                return false;
            }
        })
        if (check) {
            $("#updateForm").submit();
        }
    })
    $(".nullCheck").on("propertychange change keyup paste input", function () {
        if ($(this).val().length >= 1 && $(this).val().trim() != "") {
            $(this).attr('class', 'form-control is-valid');
        } else {
            $(this).attr('class', 'form-control is-invalid');
            $(this).nextAll('div.invalid-feedback').text('1자 이상 입력해주세요');
        }
        if ($(this).val().length >= 100) {
            $(this).attr('class', 'form-control is-invalid');
            $(this).nextAll('div.invalid-feedback').text('100자 미만으로 입력해주세요');
        }
    });

    $("#pwCheck").on("propertychange change keyup paste input", function () {
        if ($(this).val() == $('#pw').val()) {
            $(this).attr('class', 'form-control is-valid nullCheck');
        } else {
            $(this).attr('class', 'form-control is-invalid nullCheck');
            $(this).nextAll('div.invalid-feedback').text('일치하지 않습니다');
        }
    });

    $("#pwChange").on("propertychange change keyup paste input", function () {
        if ($(this).val().length >= 8 && $(this).val().trim() != "") {
            $(this).attr('class', 'form-control is-valid');
        } else {
            $(this).attr('class', 'form-control is-invalid');
            $(this).nextAll('div.invalid-feedback').text('8자 이상 입력해주세요');
        }
        if ($(this).val().length >= 100) {
            $(this).attr('class', 'form-control is-invalid');
            $(this).nextAll('div.invalid-feedback').text('100자 미만으로 입력해주세요');
        }
    });

</script>
</body>
</html>
