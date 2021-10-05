<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
		<jsp:include page="../../fix/navbar.jsp" />
	</c:if>
	<c:if test="${sessionScope.loginId ne null}">
		<jsp:include page="../../fix/loginNavbar.jsp" />
	</c:if>
	<jsp:include page="../../fix/menu.jsp" />
	<div class="row">
		<jsp:include page="../adminSidebar.jsp" />
		<div class="col w-100 p-0">
			<div class="container px-3 my-2">

				<h3>관리자 임명</h3>
				<!-- 전체 출력에서 검색내용을  넣었을 때 해당 내용 출력-->
				<div class="row mb-1">
					<div class="input-group">
						<!-- 셀렉트 -->
						<div class="form-group col-2 mp-0 me-0">
							<select id=selectType class="form-select" name="selectType">
								<option id="nickName" value="nickName" selected>이름</option>
								<option id="id" value="id">아이디</option>
								<option id="email" value="email">이메일</option>
							</select>
						</div>
						<!-- 검색/버튼 -->
						<div class="col-10 m-0 p-0">
							<!-- 왼쪽으로 당기기 -->
							<div class="row">
								<!-- 검색 공간 -->
								<div class="form-group col-10 mp-0 me-0">
									<input type="text" class="form-control" id="insertSearch"
										name="insertSearch" />
								</div>
								<!-- 검색 버튼 공간 -->
								<div class="form-group col-2 p-0 m-0">
									<button id="searchBtn" class="btn btn-dark">검색</button>
								</div>
							</div>
						</div>
					</div>

					<table class="table table-hover text-center">
						<thead>
							<tr>
								<th scope="col" class="col-md-3">아아디</th>
								<th scope="col" class="col-md-2">이름</th>
								<th scope="col" class="col-md-3">이메일</th>
								<th scope="col" class="col-md-2">임명</th>
							</tr>
						</thead>
						<tbody id="list">
							<!-- 가져올 리스트 -->
						</tbody>
					</table>
					<div id="paginationBox">
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
$(document).on('click','.page-info',function(){
	let page = $(this).attr('page');
	var url="";
	if(searchCount==0){
		url='adminInsertAjax/'+page;
	}
	if(searchCount==1){
		url='insertSearch/'+page+"/"+$("#insertSearch").val()+"/"+$("#selectType").val();
	}
	$.ajax({
		url: url,
		type: 'get',
		dataType: 'json',
		success:function(map){
			adminList(map);
		},
		error:function(error){
			console.log(error);
		}
	});
})

	var searchCount = 0;
	
	adminInsert();
	$('#insertSearch').on('keypress', function(e) {
		if (e.keyCode == '13') {
			$('#searchBtn').click();
		}
	});
	$('#searchBtn').on('click', function() {
		searchCount = 1;
		console.log("검색체크: "+searchCount);
		$.ajax({
			url : 'insertSearch/1/'+$("#insertSearch").val()+"/"+$("#selectType").val(),
			type : 'get',
			dataType : 'JSON',
			success : function(map) {
				adminList(map);
			},
			error : function(error) {
				console.log(error);
			}
		});
	});

	function adminInsert() {
		console.log("jsp에서 관리자 ajax조회");
		searchCount = 0;
		console.log("검색체크: "+searchCount);
		$.ajax({
			url : 'adminInsertAjax/1',
			type : 'get',
			dataType : 'json',
			success : function(map) {
				adminList(map);
			},
			error : function(error) {
				console.log(error);
			}

		});
	}
	/* onclick='location.href=/final_Project/adminInsertAuthority' */
	/* 관리자 임명 리스트 출력 */
	function adminList(map) {
		var content = "";
		for (var i = 0; i < map.list.length; i++) {
			content += "<tr>";
			content += "<td class='align-middle'>" + map.list[i].id + "</td>";
			content += "<td class='align-middle'>" + map.list[i].nickName + "</td>";
			content += "<td class='align-middle'>" + map.list[i].email + "</td>";
			content += "<td class='align-middle'>";
			content += "<a class='btn btn-sm btn-dark' href='adminInsertAuthority?id=" + map.list[i].id
					+ "'>임명</a>";
			content += "</td>";
			content += "</tr>";
		}
		$("#list").empty();
		$("#list").append(content);
		
		
		
		
		/* 페이지네이션 */
	    content = '';
	    content += '<ul class="pagination justify-content-center">'
	    if (map.startPage != 1) {
	        content += '<li class="page-item">'
	        content += '<a class="page-link page-info" page="' + (map.startPage - 1) + '" aria-label="Previous" style="cursor:pointer;">'
	        content += '<span aria-hidden="true">&laquo;</span>'
	        content += '</a>'
	        content += '</li>'
	    }
	    for (let i = map.startPage; i <= map.endPage; i++) {
	        if (map.currPage != i) {
	            content += '<li class="page-item"><a style="cursor:pointer;" class="page-link page-info" page="' + i + '" >' + i + '</a></li>'
	        } else {
	            content += '<li class="page-item active"><a class="page-link">' + i + '</a></li>'
	        }
	    }
	    if (map.totalPage != map.endPage) {
	        content += '<li class="page-item">'
	        content += '<a class="page-link page-info" page="' + (map.endPage + 1) + '" aria-label="Next" style="cursor:pointer;">'
	        content += '<span aria-hidden="true">&raquo;</span>'
	        content += '</a>'
	        content += '</li>'
	    }
	    content += '</ul>'
	    $('#paginationBox').empty();
	    $('#paginationBox').append(content);
		
	}
</script>
</html>
