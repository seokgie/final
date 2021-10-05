<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<%-- 메뉴바 --%>
<div class="bg-white border-bottom border-top">
    <div class="d-flex justify-content-end">
        <img class="ms-3 mt-3" src="${path}/resources/img/icon.png" style="height:35px"/>
        <div class="me-auto mt-1">
            <a class="fs-2 mb-1 navbar-brand d-inline-flex ms-3 text-black" href="${path}">모닥불</a>
        </div>
        <div>
            <div class="d-flex justify-content-center">
                <div class="dropdown">
                    <a class="nav-link fs-5 mx-3 text-black mt-2" data-bs-toggle="dropdown"
                       aria-expanded="true" href="">검색</a>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="${path}/campingSearch/tagSearch/1">태그검색</a></li>
                        <li><a class="dropdown-item" href="${path}/campingSearch/mapSearch">지도로검색</a></li>
                    </ul>
                </div>
                <div class="dropdown">
                    <a class="nav-link fs-5 mx-3 text-black mt-2" data-bs-toggle="dropdown"
                       aria-expanded="true" href="">캠핑정보</a>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
                        <li><a class="dropdown-item" href="${path}/campingInfo/campingRecipe">캠핑레시피</a></li>
                        <li><a class="dropdown-item" href="${path}/campingInfo/campingTip">캠핑팁</a></li>
                        <li><a class="dropdown-item" href="${path}/campingInfo/campingWeather">날씨</a></li>
                        <li><a class="dropdown-item" href="${path}/campingInfo/campingParking">차박지도</a></li>
                    </ul>
                </div>
                <div class="dropdown">
                    <a class="nav-link fs-5 mx-3 text-black mt-2" href="" data-bs-toggle="dropdown"
                       aria-expanded="true">캠핑톡</a>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton3">
                        <li><a class="dropdown-item" href="${path}/campingTalk/reviewBoard">캠핑리뷰</a></li>
                        <li><a class="dropdown-item" href="${path}/campingTalk/freeBoard">자유게시판</a></li>
                    </ul>
                </div>
                <div class="dropdown">
                    <a class="nav-link fs-5 mx-3 text-black mt-2" data-bs-toggle="dropdown"
                       aria-expanded="true" href="">고객센터</a>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton4">
                        <li><a class="dropdown-item" href="${path}/serviceCenter/questionBoard/1">문의하기</a></li>
                        <li><a class="dropdown-item" href="${path}/serviceCenter/noticeBoard">공지사항</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

