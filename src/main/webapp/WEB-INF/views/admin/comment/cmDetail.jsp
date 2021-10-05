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
    <jsp:include page="../../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../../fix/loginNavbar.jsp"/>
</c:if>
<jsp:include page="../../fix/menu.jsp"/>
<div class="row">
    <jsp:include page="../adminSidebar.jsp"/>
    <div class="col w-100 p-0"> 
    <h3>일반 댓글 상세</h3>
      <div class="d-flex justify-content-center">
      
				<!-- 전체 출력에서 검색내용을  넣었을 때 해당 내용 출력-->
				<div class="col-md-6 mt-5 ">
				<table class="table table-hover text-center">
					<thead>
						<tr>
							<th scope="col" class="col-md-3">댓글 번호</th>
							<td class='align-middle'>${detail.cmNum}</td>
						</tr>
						<tr>
							<th scope="col" class="col-md-3">게시판 구분</th>
							<td class='align-middle'>${detail.division}</td>
						</tr>
						<tr>
							<th scope="col" class="col-md-3">아아디</th>
							<td class='align-middle'>${detail.id}</td>
						</tr>
						<tr>
							<th scope="col" class="col-md-3">댓글내용</th>
							<td class='align-middle'>${detail.content}</td>
						</tr>
						<tr>
							<th scope="col" class="col-md-3">블라인드 여부</th>
							<td class='align-middle'>${detail.delCheck}</td>
						</tr>
					</thead>
				</table>
				</div>
				
			</div>
			<div class="d-flex justify-content-center">
			<a class="btn btn-dark btn-sm" href='./comment'>리스트로</a>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="${path}/resources/js/bootstrap.js"></script>
	<script src="${path}/resources/js/bootstrap.bundle.js"></script>
	<%-- 공통 js --%>
	<script src="${path}/resources/js/common.js"></script>
</body>
<script>

	</script>
</html>
