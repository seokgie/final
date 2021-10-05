<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<div path="${path}" id="loginId" class="toast-container position-fixed bottom-0 end-0 mb-3 me-3"
     loginId="${sessionScope.loginId}">
</div>
<script>
    let loginId = $('#loginId').attr("loginId");
    let paths = $('#loginId').attr("path");
    let interval = setInterval(alarmRead, 2000);

    function alarmRead() {
        $.ajax({
            url: paths + "/alarm/read",
            type: 'post',
            data: {
                "loginId": loginId
            },
            dataType: 'json',
            success: function (data) {
                if (Object.keys(data).length != 0) {
                    if (Object.keys(data.list).length != 0) {
                        $.each(data.list, function (i, dto) {
                            print(dto);
                        })

                        $('.toast').show(300);
                        $.ajax({
                            url: paths + "/alarm/update",
                            type: 'post',
                            data: {
                                "loginId": loginId
                            },
                            dataType: 'json',
                            success: function (data) {

                            },
                            error: function (error) {
                                console.log(error);
                            }
                        })
                    }
                }
            },
            error: function (error) {
                console.log(error);
            }
        });
    }

    function print(dto) {
        let content = '<div class="toast" role="alert" aria-live="assertive" aria-atomic="true">'
        content += '<div class="d-flex">'
        content += '<div class="toast-body" id="body">'
        if (dto.content == 'cm') {
            content += dto.id + ' 님이 게시글에 댓글을 작성했습니다'
        } else if (dto.content == 'good') {
            content += dto.id + ' 님이 게시글에 좋아요를 했습니다'
        }
        content += '</div>'
        content += '<button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>';
        content += '</div>'
        $('#loginId').empty();
        $('#loginId').prepend(content);
    }

    $(document).on('click', '.btn-close', function () {
        $(this).closest('div.toast').hide(300);
    })
    /*  $(document).on('click', '.btn-close', function () {
          let alarmNum = $(this).attr('alarmNum');
          $(this).closest('div.toast').hide(300);
          $.ajax({
              url: "alarm/update",
              type: 'post',
              data: {
                  "alarmNum": alarmNum
              },
              dataType: 'json',
              success: function (data) {

              },
              error: function (error) {
                  console.log(error);
              }
          });
      })*/
</script>