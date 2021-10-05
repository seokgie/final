<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<ul class="nav nav-pills nav-fill mt-2">
    <li class="nav-item">
        <a id="menuOne" class="nav-link text-dark border-end border-dark rounded-0 fs-4"
           href="${path}/myInfo/cmList/1/review">캠핑리뷰</a>
    </li>
    <li class="nav-item">
        <a id="menuTwo" class="nav-link text-dark border-end border-dark rounded-0 fs-4"
           href="${path}/myInfo/cmList/1/free">자유게시판</a>
    </li>
    <li class="nav-item">
        <a id="menuThree" class="nav-link text-dark fs-4 rounded-0 border-end border-dark"
           href="${path}/myInfo/cmList/1/notice">공지사항</a>
    </li>
    <li class="nav-item">
        <a id="menuFour" class="nav-link text-dark fs-4 rounded-0 border-end border-dark"
           href="${path}/myInfo/cmList/1/camping">캠핑장</a>
    </li>
    <li class="nav-item">
        <a id="menuFive" class="nav-link text-dark fs-4 rounded-0 border-end border-dark"
           href="${path}/myInfo/cmList/1/parking">차박정보</a>
    </li>
    <li class="nav-item">
        <a id="menuSix" class="nav-link text-dark fs-4 rounded-0"
           href="${path}/myInfo/reportCmList/1">신고한댓글</a>
    </li>
</ul>
