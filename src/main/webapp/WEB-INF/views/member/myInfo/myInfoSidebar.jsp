<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<div class="flex-shrink-0 p-3 border-end vh-100" style="width: 280px;">
    <ul class="list-unstyled ms-2">
        <li class="mb-1">
            <p class="ms-4 align-items-center menuClick fw-bold fs-2" style="cursor: default">내 정보</p>
            <div class="">
                <ul class="ms-4 list-unstyled fw-normal pb-1 listHide">
                    <li><a href="${path}/myInfo/memberUpdate" class="link-dark rounded fs-4">정보수정</a></li>
                    <li><a href="${path}/myInfo/memberPassChangeForm" class="link-dark rounded fs-4">비밀번호변경</a></li>
                    <li><a href="${path}/myInfo/memberDrop" class="link-dark rounded fs-4">회원탈퇴</a></li>
                </ul>
            </div>
        </li>
    </ul>
    <ul class="list-unstyled border-top ms-2">
        <li class="mb-1 mt-3">
            <p class="ms-4 align-items-center menuClick fw-bold fs-2" style="cursor: default">예약현황</p>
            <div class="">
                <ul class="ms-4 list-unstyled fw-normal pb-1 listHide">
                    <li><a href="${path}/myInfo/reserveCheck/1" class="link-dark rounded fs-4">예약확인</a></li>
                </ul>
            </div>
        </li>
    </ul>
    <ul class="list-unstyled border-top ms-2">
        <li class="mb-1 mt-3">
            <p class="ms-4 align-items-center menuClick fw-bold fs-2" style="cursor: default">목록</p>
            <div class="">
                <ul class="ms-4 list-unstyled fw-normal pb-1 listHide">
                    <li><a href="${path}/myInfo/cmList/1/review" class="link-dark rounded fs-4">댓글</a></li>
                    <li><a href="${path}/myInfo/boardList/1/reviewBoard" class="link-dark rounded fs-4">게시글</a></li>
                    <li><a href="${path}/myInfo/wantToGo/1" class="link-dark rounded fs-4">가고싶어요</a></li>
                </ul>
            </div>
        </li>
    </ul>
</div>
