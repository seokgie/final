<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<ul class="nav nav-pills nav-fill mt-2">
    <li class="nav-item">
        <a id="menuOne" class="nav-link text-dark border-end border-dark rounded-0 fs-4" aria-current="page"
           href="${path}/myInfo/boardList/1/reviewBoard">캠핑리뷰</a>
    </li>
    <li class="nav-item">
        <a id="menuTwo" class="nav-link text-dark border-end border-dark rounded-0 fs-4"
           href="${path}/myInfo/boardList/1/freeBoard">자유게시판</a>
    </li>
    <li class="nav-item">
        <a id="menuThree" class="nav-link text-dark border-end border-dark rounded-0 fs-4"
           href="${path}/myInfo/boardList/1/questionBoard">문의하기</a>
    </li>
    <li class="nav-item">
        <a id="menuFour" class="nav-link text-dark fs-4 rounded-0"
           href="${path}/myInfo/boardList/1/noticeBoard">공지사항</a>
    </li>
</ul>
