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
    <%--<link href="${path}/resources/css/bootstrap.css" rel="stylesheet">--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <%-- 공통 css --%>
    <link href="${path}/resources/css/common.css?var=2" rel="stylesheet">
</head>
<body>
<%-- 상단 로그인 추가 --%>
<c:if test="${sessionScope.loginId eq null}">
    <jsp:include page="../../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../../fix/loginNavbar.jsp"/>
</c:if>
<%-- 상단 메뉴바 --%>
<jsp:include page="../../fix/menu.jsp"/>
<%-- 내용 넣으세요 --%>
<div class="container px-3 my-3">
	<div class="container mx-2">
    	<h3>게시글 수정</h3>
		<form action="../freeUpdate" method="post" enctype="multipart/form-data">
			제목
			<div class="input-group mb-3">
				<input type="hidden" name="boardNum" value="${dto.boardNum}" class="boardnum"/>
				<input type="text" name="title" class="form-control" placeholder="${dto.title}" required="required" aria-label="Username" aria-describedby="basic-addon1">
			</div>
			내용
			<div class="input-group mb-3">
				<textarea name="content" style="resize:none" rows="10" class="form-control"  placeholder="${dto.content}" required="required" aria-label="With textarea"></textarea>
			</div>
			업로드한 사진
			<div class="row">
				<c:forEach var="photo" items="${phoDtos}">
				<div class="row ms-1">
					<a href='#this' class="oriphoto" value="${photo.newFileName}">${photo.oriFileName}    [삭제]</a>
				</div>
				</c:forEach>
			</div>
			<div class="form-group mt-3" id="file-list">
				<a href="#this" onclick="addFile()">파일추가(+)</a>
			    <div class="file-group">			
			    </div>
			</div>
			<hr/>
			<div class="d-flex flex-row-reverse">
				<button class="btn btn-primary mx-2" type="submit">등록</button>
			   	<input class="btn btn-primary d-flex" type="button" value="목록" onclick="location.href='./freeBoard'">
			</div>
		</form>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>

<script>

	$(document).ready(function() {
		$("a[name='file-delete']").on("click", function(e) {
			e.preventDefault();
			deleteFile($(this));
		});
	})

	function addFile() {
		var str = "<div class='file-group'><input type='file' name='file'><a href='#this' name='file-delete'>삭제</a></div>";
		
		$("#file-list").append(str);
		$("a[name='file-delete']").on("click", function(e) {
			e.preventDefault();
			deleteFile($(this));
		});
	}

	function deleteFile(obj) {
		obj.parent().remove();
	}

	var newfilename = "";
	var boardnum = $(".boardnum").val();

	$(document).on("click", ".oriphoto", function() {
		newfilename = $(this).attr('value');
		alert(newfilename + "/" + boardnum);
		$.ajax({
			type : "POST",
			url : "../freePhotoDel",
			data : {
				"newFileName" : newfilename,
				"boardNum" : boardnum
			},
			success : function(data) {
				console.log(data);
			},
			error : function(data) {
				console.log(data);
			}
		});

		deleteFile($(this));
	});
	
</script>

</body>
</html>
