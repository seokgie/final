<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page session="true"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<html>
<head>

<title>Final</title>
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
<link href="${path}/resources/css/common.css?var=2" rel="stylesheet">
</head>
<body>
	<%-- 상단 로그인 추가 --%>
	<c:if test="${sessionScope.loginId eq null}">
		<jsp:include page="../../fix/navbar.jsp" />
	</c:if>
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="../../fix/loginNavbar.jsp" />
	</c:if>
	<%-- 상단 메뉴바 --%>
	<jsp:include page="../../fix/menu.jsp" />
	<%-- 내용 넣으세요 --%>
	<div class="container px-3 mt-2">
		<h3>공지사항</h3>
		<table class="table table-hover text-center">
			<thead>
				<tr>
					<th scope="col" class="col-md-7">제목</th>
					<th scope="col" class="col-md-1 ">작성자</th>
					<th scope="col" class="col-md-2 ">날짜</th>
					<th scope="col" class="col-md-1 ">조회수</th>
				</tr>
			</thead>
			<tbody id="list">
				<c:forEach items="${map.list}" var="i" varStatus="vs">
					<tr onClick="location.href='${path}/serviceCenter/noticeDetail/${i.boardNum}'" style="cursor:pointer;">
						<td class="py-3">${i.title}</td>
						<td class="py-3">${i.id}</td>
						<td class="py-3">${i.dates}</td>
						<td class="py-3">${i.boardHit}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<ul class="pagination justify-content-center">
			<c:if test="${map.startPage ne 1}">
				<li class="page-item"><a class="page-link"
					href="${path}/serviceCenter/noticeBoard/${map.startPage-1}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
				</a></li>
			</c:if>
			<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
				<c:if test="${i ne map.currPage}">
					<li class="page-item"><a class="page-link"
						href="${path}/serviceCenter/noticeBoard/${i}">${i}</a></li>
				</c:if>
				<c:if test="${i eq map.currPage}">
					<li class="page-item active"><a class="page-link">${i}</a></li>
				</c:if>
			</c:forEach>
			<c:if test="${map.totalPage ne map.endPage}">
				<li class="page-item"><a class="page-link"
					href="${path}/serviceCenter/noticeBoard/${map.endPage+1}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
			</c:if>
		</ul>
		<c:if test="${sessionScope.admin eq 'Y'}">
		<input class="btn btn-primary" type="button" value="공지사항쓰기"
			onclick="location.href='noticeWriteForm'">
		</c:if>
	</div>
	<jsp:include page="../../fix/alarm.jsp"/>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="${path}/resources/js/bootstrap.js"></script>
	<script src="${path}/resources/js/bootstrap.bundle.js"></script>
	<script src="${path}/resources/js/common.js"></script>
	<script>
	
	
		/* var currPage = 1;
		var per = 10;
		//listCall(currPage);


		function listCall(page) {
			//{pagePerNum}/{page}
			var reqUrl = 'noticeBoardList/' + per + "/" + page;
			//console.log('request page' + reqUrl);
			console.log(page + " page가져오기");
			console.log(reqUrl);

			 $.ajax({
				url : reqUrl,
				type : 'get',
				dataType : 'json',
				success : function(data) { //데이터가 성공적으로 들어왔다면
					console.log(data);
					listPrint(data.list); //리스트 그리기
					currPage = data.currPage;
					//페이징 처리
					$("#pagination").twbsPagination({
						startPage:data.currPage,//시작페이지 -> service에서 sql실행하여 map으로 보낸 데이타 값
						totalPages:data.pages,//총 페이지 갯수 -> service에서 sql실행하여 map으로 보낸 데이타 값
						visiblePages:5,//보여줄 페이지 갯수
						onPageClick: function(e,page){
							console.log(e,page);
							listCall(page);
						}
					});
				},
				error : function(error) {
					console.log(error);
				}
			});
		}
		
		function listPrint(list){
			var content = "";
			
			for(var i = 0; i<list.length; i++){
				
				content += "<tr onClick = \" location.href='noticeDetail/"+list[i].boardNum+"'\">";
				content +="<td>"+list[i].title+"</td>";
				content +="<td>"+list[i].id+"</td>";
				var date = new Date(list[i].dates);
				content +="<td>"+date.toLocaleDateString("ko-KR")+"</td>";
				content +="<td>"+list[i].boardHit+"</td>";
				content +="</tr>";
				$("#list").empty();
				$("#list").append(content);
			}
		} */
	</script>
</body>
</html>
