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
<%-- 상단 메뉴바 추가 --%>
<c:if test="${sessionScope.loginId eq null}">
    <jsp:include page="../../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../../fix/loginNavbar.jsp"/>
</c:if>
<jsp:include page="../../fix/menu.jsp"/>
<div class="container px-3 py-3">
    <div class="pt-4 border-bottom border-dark">
        <h2 class="fw-bold">회원가입</h2>
    </div>
    <div class="d-flex justify-content-center my-2">
        <form action="${path}/member/join" class="w-50" method="post" id="joinForm">
            <div class="mb-3">
                <label for="id" class="form-label">아이디</label>
                <input name="id" type="text" class="form-control nullCheck" id="id" placeholder="필수정보 입니다">
                <div class="invalid-feedback">다시 중복확인 해주세요</div>
                <div class="valid-feedback">사용 가능합니다</div>
                <a id="idCheck" class="btn btn-warning btn-sm mt-2">중복확인</a>
            </div>
            <div class="mb-3">
                <label for="pw" class="form-label">비밀번호</label>
                <input name="pw" type="password" class="form-control nullCheck goCheck" id="pw" placeholder="필수정보 입니다">
                <div class="invalid-feedback"></div>
            </div>
            <div class="mb-3">
                <label for="nickName" class="form-label">닉네임</label>
                <input name="nickName" type="text" class="form-control nullCheck" id="nickName">
                <div class="invalid-feedback">1자 이상 입력해주세요</div>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">이메일</label>
                <input name="email" type="text" class="form-control nullCheck" id="email" placeholder="필수정보 입니다"
                       readonly>
                <div class="invalid-feedback">이메일 인증 해주세요</div>
                <div class="valid-feedback">인증 성공!</div>
                <button type="button" class="btn btn-warning btn-sm mt-2" data-bs-toggle="modal"
                        data-bs-target="#exampleModal">
                    이메일인증
                </button>
            </div>
            <div class="mb-3 text-center">
                <input id="joinBtn" type="button" class="btn btn-warning" value="회원가입">
            </div>
        </form>
        <!-- 팝업창 -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel"
             aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">이메일 인증</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div>
                            <label for="code" class="form-label">이메일</label>
                            <input class="form-control" type="text" id="emailSender" name="emailSender"
                                   placeholder="이메일을 입력해주세여">
                            <div class="valid-feedback">전송되었습니다</div>
                            <button id="emailCheck" type="button" class="btn btn-warning btn-sm mt-2">이메일 전송
                            </button>
                        </div>
                        <div>
                            <label for="code" class="form-label">인증코드</label>
                            <input class="form-control" type="text" id="code" name="code" placeholder="코드를 입력해주세요">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="close" type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기
                        </button>
                        <button id="right" type="button" class="btn btn-warning">확인</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<c:if test="${suc eq 0}">
    <script>
        alert('다시 시도해주세요');
    </script>
</c:if>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    $('#idCheck').on('click', function () {
        let id = $('#id').val();
        if (id == "") {
            $(this).prevAll('div.invalid-feedback').text('1자 이상 입력해주세요');
            $("#id").addClass("is-invalid");
        } else {
            $.ajax({
                url: 'idCheck',
                data: {
                    id: id
                },
                type: 'post',
                dataType: "json",
                success: function (data) {
                    if (data) {
                        $('#id').removeClass('is-invalid');
                        $('#id').addClass('is-valid');
                        $('#id').prop("readonly", true);
                    } else {
                        $('#id').addClass('is-invalid');
                        $('#id').removeClass('is-valid');
                    }
                },
                error: function (e) {
                    console.log(e);
                }
            })
        }
    });

    $('#emailCheck').on('click', function () {
        let email = $('#emailSender').val();
        $('#emailSender').prop('readonly', true);
        $('#emailSender').addClass('is-valid');
        $.ajax({
            url: 'emailCheck',
            data: {
                email: email
            },
            type: 'post',
            dataType: "json",
            success: function (data) {
                console.log(data);
            },
            error: function (e) {
                console.log(e);
            }
        })
    })

    $('#right').on('click', function () {
        let code = $('#code').val();
        let email = $('#emailSender').val();
        console.log(code);
        $.ajax({
            url: 'codeCheck',
            data: {
                code: code
            },
            type: 'post',
            dataType: "json",
            success: function (data) {
                console.log(data);
                if (data) {
                    $('#email').val(email);
                    $('#email').addClass("is-valid");
                    $('#close').click();
                } else {
                    alert('이메일 코드가 다릅니다 다시 입력해주세요');
                }
            },
            error: function (e) {
                console.log(e);
            }
        })
    })
    // 유효성 검사
    $('#joinBtn').on('click', function () {
        let check = true;
        $('.nullCheck').each(function (index, el) {
            if ($(this).hasClass('is-valid')) {
                return true;
            } else {
                check = false;
                $(this).addClass('is-invalid');
                return false;
            }
        })
        if (check) {
            $("#joinForm").submit();
        }
    })
    $("#pw").on("propertychange change keyup paste input", function () {
        if ($(this).val().length >= 8) {
            $(this).attr('class', 'form-control is-valid');
        } else {
            $(this).attr('class', 'form-control is-invalid');
            $(this).nextAll('div.invalid-feedback').text('8자 이상 입력해주세요');
        }
        if ($(this).val().length >= 100) {
            $(this).attr('class', 'form-control is-invalid');
            $(this).nextAll('div.invalid-feedback').text('100자 미만으로 입력해주세요');
        }
    });
    $("#nickName").on("propertychange change keyup paste input", function () {
        if ($(this).val().length >= 1) {
            $(this).attr('class', 'form-control is-valid');
        } else {
            $(this).attr('class', 'form-control is-invalid');
            $(this).nextAll('div.invalid-feedback').text('1자 이상 입력해주세요');
        }
        if ($(this).val().length >= 100) {
            $(this).attr('class', 'form-control is-invalid');
            $(this).nextAll('div.invalid-feedback').text('100자 미만으로 입력해주세요');
        }
    });
</script>
</body>
</html>
