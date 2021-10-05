package com.gudi.main.util;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;

public class Interceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        String uri = request.getRequestURI();
        String ctx = request.getContextPath();
        String addr = uri.substring(ctx.length());
        // 예약하기,로그인 체크
        if (addr.contains("/reserve/campingReserve")) {
            if (session.getAttribute("loginId") == null) {
                response.setContentType("text/html; charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('로그인 해주세요 ^^'); location.href='" + ctx + "/member/loginForm';</script>");
                out.flush();
            }
        }
        if (addr.contains("/serviceCenter/noticeWriteForm")||addr.contains("/serviceCenter/noticeDel")||addr.contains("/serviceCenter/noticeUpdateForm")) {
        	if(session.getAttribute("admin") == null || session.getAttribute("admin").equals("N")) {
        		response.setContentType("text/html; charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('관리자만 가능합니다 ^^'); location.href='" + ctx + "/';</script>");
                out.flush();
        	}
        }
        if(addr.contains("/admin")){
            if(session.getAttribute("admin") == null || session.getAttribute("admin").equals("N")) {
                response.setContentType("text/html; charset=UTF-8");
                PrintWriter out = response.getWriter();
                out.println("<script>alert('관리자만 가능합니다 ^^'); location.href='" + ctx + "/';</script>");
                out.flush();
            }
        }
        return true;
        
        
        
        
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }
}
