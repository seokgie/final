<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="flex-shrink-0 p-3 border-end vh-100" style="width: 280px;">
    <ul class="list-unstyled ms-2">
        <li class="mb-1">
            <p class="ms-4 align-items-center menuClick fw-bold fs-2" style="cursor: default">관리자권한</p>
            <div class="">
                <ul class="ms-4 list-unstyled fw-normal pb-1 listHide">
                    <li><a href="${path}/admin/authority" class="link-dark rounded fs-4">관리자조회</a></li>
                    <li><a href="${path}/admin/adminInsert" class="link-dark rounded fs-4">관리자임명</a></li>
                </ul>
            </div>
        </li>
    </ul>
    <ul class="list-unstyled border-top ms-2">
        <li class="mb-1 mt-3">
            <p class="ms-4 align-items-center menuClick fw-bold fs-2" style="cursor: default">목록정보</p>
            <div class="">
                <ul class="ms-4 list-unstyled fw-normal pb-1 listHide">
                    <li><a href="${path}/admin/memberInfo" class="link-dark rounded fs-4">회원정보</a></li>
                    <li><a href="${path}/admin/memberReserve" class="link-dark rounded fs-4">회원예약정보</a></li>
                    <li><a href="${path}/admin/boardList" class="link-dark rounded fs-4">게시글</a></li>
                </ul>
            </div>
        </li>
    </ul>
    <ul class="list-unstyled border-top ms-2">
        <li class="mb-1 mt-3">
            <p class="ms-4 align-items-center menuClick fw-bold fs-2" style="cursor: default">댓글정보</p>
            <div class="">
                <ul class="ms-4 list-unstyled fw-normal pb-1 listHide">
                    <li><a href="${path}/admin/comment" class="link-dark rounded fs-4">일반댓글</a></li>
                    <li><a href="${path}/admin/reportComment" class="link-dark rounded fs-4">신고댓글</a></li>
                </ul>
            </div>
        </li>
    </ul>
</div>
