<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%-- 최상단 메뉴바 --%>
<div style="background-color: #DCDCDC">
    <div class="d-flex justify-content-end">
        <div class="border-end border-dark">
            <a class="fs-6 btn-sm btn-outline-light text-dark" href="${path}/member/loginForm" style="text-decoration:none">로그인</a>
        </div>
        <div class="border-end border-dark">
            <a href="${path}/member/agreeForm" class="fs-6 btn-sm btn-outline-light text-dark" style="text-decoration:none">회원가입</a>
        </div>
        <div class="">
            <a href="${path}/serviceCenter/noticeBoard" class="fs-6 btn-sm btn-outline-light text-dark" style="text-decoration:none">공지사항</a>
        </div>
    </div>
</div>
