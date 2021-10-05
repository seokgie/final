<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
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
    <link href="${path}/resources/css/common.css?var=7" rel="stylesheet">
</head>
<body>
<%-- 상단 로그인 추가 --%>
<c:if test="${sessionScope.loginId eq null}">
    <jsp:include page="../fix/navbar.jsp"/>
</c:if>
<c:if test="${sessionScope.loginId ne null}">
    <jsp:include page="../fix/loginNavbar.jsp"/>
</c:if>
<%-- 상단 메뉴바 --%>
<jsp:include page="../fix/menu.jsp"/>
<%-- 내용 넣으세요 --%>
<div class="px-3 mt-3">
    <div class="row">
        <div class="col-4 border-end border-black text-center"
             style="overflow-y: scroll; height: 700px;">
            <div id="dimention" class="d-flex justify-content-start row">
                <div id="list" class="col-6 ">
                    <!-- 들어갈곳  -->
                </div>
                <div id="list1" class="col-6 ">
                    <!-- 들어갈곳  -->
                </div>
            </div>
            <div class="btn-group mt-2" role="group"
                 aria-label="Basic mixed styles example">
                <button path="${path}" id="first" type="button" class="btn btn-warning">처음</button>
                <button id="pev" type="button" class="btn btn-success">이전</button>
                <button id="next" type="button" class="btn btn-danger">다음</button>
            </div>
        </div>
        <div class="col-8">
            <div id="player" style="width: 100%; height: 700px;"></div>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${path}/resources/js/bootstrap.js"></script>
<script src="${path}/resources/js/bootstrap.bundle.js"></script>
<script src="${path}/resources/js/common.js"></script>
<script>
    var next = "";
    var pev = "";
    var page = 1;
    let path = $('#first').attr('path');
    first();


    function read(page) {
        console.log("함수 페이지" + page);
        $.ajax({
            url: path + '/campingInfo/campingApi/' + page,
            type: 'GET',
            dataType: 'JSON',
            success: function (data) {
                display1(data.items);
            },
            error: function (e) {
                console.log(e);
            }
        });
    }


    function display1(data) {
        var list = $("#list1");
        list.empty();
        for (var i = 0; i < data.length; i++) {
            var item = printList1(i, data[i]);

            (function (data) {
                item.onclick = function () {
                    print1(data);
                }
            })(data[i]);
            list.append(item);
        }
    }


    function printList1(i, data) {
        var el = document.createElement('div'),
            content = "<div class='card border-dark'  style='cursor:pointer; height:300px;'>";
        content += '<div class="card-body_' + i + '">';
        content += "<h5 class='card-title'>" + data.title + "</h5><hr/>";
        content += "<p class='card-text lineCard'>" + data.description + "</p>";
        /* content += "<p class='card-text'>상세보기</p>"; */
        content += "</div>";
        content += "</div>";
        content += "</div>";
        el.innerHTML = content;
        el.className = "mb-1";
        return el;
    }


    function print1(data) {
        $("#player").empty();
        var content = '<div style="height: auto;">';
        content += '<iframe src="' + data.link
            + '" width="100%" height="700" >블로그</iframe>'
        content += '</div>'
        $("#player").append(content);
    };


    $("#first").on("click", function () {
        first();
    });


    function first() {
        $.ajax({
            url: 'https://www.googleapis.com/youtube/v3/search?key=AIzaSyBB3fW64jEBLy4T8ZG5zfH_TYKL3xPbBNc',
            type: 'get',
            dataType: 'json',
            data: {
                /* "key" : key, */
                "part": "snippet",
                "maxResults": 5,
                "q": "캠핑꿀팁"
            },
            success: function (data) {
                page = 1;
                read(page);
                display(data.items);
                next = data.nextPageToken;
                print(data.items[0]);
            },
            error: function (e) {
                console.log(e);
            }
        });
    };


    function display(data) {
        var listEl = $('#list');
        listEl.empty();
        for (let i = 0; i < data.length; i++) {
            var itemEl = listPrint(i, data[i]);

            (function (data) {
                itemEl.onclick = function () {
                    print(data);
                }
            })(data[i]);
            listEl.append(itemEl);
        }
    }


    function listPrint(index, data) {
        var el = document.createElement('div'),
            content = "<div class='card border-dark text-center'  style='cursor:pointer; height:300px;'>";
        content += '<div class="card-body_' + index + '"><img src="' + data.snippet.thumbnails.high.url + '" class="card-img-top" alt="...">';
        content += "<h5 class='card-title tineCard'>" + data.snippet.title + "</h5>";
        // content += "<p class='card-text'>"+data.description+"</p>";
        content += "</div></div></div>";
        el.innerHTML = content;
        el.className = "mb-1";
        return el;
    }


    function print(item) {
        $("#player").empty();
        var content = '<div style="height: auto;">';
        content += '<iframe width="100%" height="500" src="https://www.youtube.com/embed/'
            + item.id.videoId
            + '" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>'
        content += '</div> <div class="card"><div class="card-body"><h5 class="card-title">'
            + item.snippet.title + '</h5><p class="card-text">'
        content += item.snippet.description + '</p></div></div></div>'
        $("#player").append(content);
    }


    $("#next").on("click", function () {
        $.ajax({
            url: 'https://www.googleapis.com/youtube/v3/search?key=AIzaSyBB3fW64jEBLy4T8ZG5zfH_TYKL3xPbBNc',
            type: 'get',
            dataType: 'json',
            data: {
                "part": "snippet",
                "maxResults": 5,
                "q": "캠핑꿀팁",
                "pageToken": next
            },
            success: function (data) {
                page = page + 5;
                read(page);
                display(data.items);
                next = data.nextPageToken;
                pev = data.prevPageToken;
            },
            error: function (e) {
                console.log(e);
            }
        });
    });


    $("#pev").on("click", function () {
        $.ajax({
            url: 'https://www.googleapis.com/youtube/v3/search?key=AIzaSyBB3fW64jEBLy4T8ZG5zfH_TYKL3xPbBNc',
            type: 'get',
            dataType: 'json',
            data: {
                "part": "snippet",
                "maxResults": 5,
                "q": "캠핑꿀팁",
                "pageToken": pev
            },
            success: function (data) {
                page = page - 5;
                read(page);
                display(data.items);
                next = data.nextPageToken;
                pev = data.prevPageToken;
            },
            error: function (e) {
                console.log(e);
            }
        });
    });
</script>
</html>
