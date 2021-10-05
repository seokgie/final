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
        <div class="container px-3 my-2">
         <h3>회원정보</h3>
				<!-- 전체 출력에서 검색내용을  넣었을 때 해당 내용 출력-->
				<div class="row mb-1">
				
				<form action="memberInfoBlackInsert"  method="post">
				<table class="table text-center">
					<thead>
						<tr>
							<th class="col-md-5">아아디</th>
							<input name="id" class= "form-control" type="hidden" value="${id}"/>
							<th class="col-md-4">이름</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${id}</td>
							<td>${nickName}</td>
						</tr>
					</tbody>
				</table>
				</div>
				<div class="row mb-1">
				<table class="table text-center">
					<thead>
						<tr>
							<th class="col-md-3">사유추가</th>
							
						</tr>
					</thead>
					<tbody id ="list">
						<tr>
							<td class='align-middle'>
							<textarea class= "form-control" name="reason" rows="10" cols="50" placeholder="사유를 입력하세요."style="resize:none"></textarea>
							</td>
							
						</tr>
					</tbody>
				</table>
				</div>
				<div class="center">
				
				<input class ="btn btn-dark btn-sm" type="submit" value="추가"/>
				<%-- <a class='btn btn-sm btn-dark' href="memberInfoBlackInsert?id=${id} ">추가</a> --%>
				<a class='btn btn-sm btn-dark' href='memberInfo'>리스트로</a>
				</div>
				   
            
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

/* var reason = document.getElementById("reason").value;
console.log(reason);
button();
function button(){
	var content="";
	content+="<a class='btn btn-sm btn-dark' href='memberInfoBlackInsert?id="+id+"'>추가</a>";
	content+="<a class='btn btn-sm btn-dark' href='memberInfo'>리스트로</a>";
	$("#list").empty();
	$("#list").append(content);
} */
</script>

</html>