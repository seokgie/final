<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>에러</title>
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
    <link href="${path}/resources/css/common.css?var=3" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="container">
        <div class="d-flex justify-content-center">
            <img class="ms-3 mt-3" src="${path}/resources/img/icon.png" style="height:35px"/>
            <div class="mt-1">
                <a class="fs-2 mb-1 navbar-brand d-inline-flex ms-3 text-black" href="${path}">모닥불</a>
            </div>
        </div>
        <div class="d-flex justify-content-center">
            <div class="w-50">
                <p class="fs-4">
                    죄송합니다.<br/>
                    요청하신 페이지를 찾을 수 없습니다.<br/>
                    방문하시려는 페이지의 주소가 잘못 입력되었거나,<br/>
                    페이지의 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.<br/>
                    입력하신 주소가 정확한지 다시 한번 확인해 주시기 바랍니다.<br/>
                    관련 문의사항은 모닥불 고객센터에 알려주시면 친절하게 안내해 드리겠습니다.<br/>
                    감사합니다.<br/>
                </p>
            </div>
        </div>
        <div class="text-center">
            <a href="${path}" class="btn btn-warning">메인으로</a>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js?var=3"></script>
</body>
</html>
