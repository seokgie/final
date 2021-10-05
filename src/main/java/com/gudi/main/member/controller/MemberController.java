package com.gudi.main.member.controller;

import com.gudi.main.dtoAll.MemberDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.gudi.main.member.service.MemberService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

@Controller
@RequestMapping(value = "/member")
public class MemberController {

    @Autowired
    MemberService service;
    Logger logger = LoggerFactory.getLogger(this.getClass());

    //아이디찾기

    @RequestMapping(value = "/idFindForm")
    public String idFindForm(Model model) {

        return "member/login/idFind/idFindForm";
    }


    //아이디찾기 기능
    @RequestMapping(value = "/idFind", method = RequestMethod.POST)
    public String idFind(Model model, @RequestParam HashMap<String, String> params) {

        logger.info("아이디확인" + params);
        ArrayList<String> list = service.idFind(params);

        if (list.size() == 0) {
            model.addAttribute("suc", false);
            return "member/login/idFind/idFindForm";
        } else {
            model.addAttribute("list", list);
            return "member/login/idFind/idFindResult";
        }
    }

    //비밀번호찾기 기능
    @RequestMapping(value = "/passFind")
    public String passFind(Model model, @RequestParam HashMap<String, String> params) {
        String id = service.passFind(params);
        if (id == null) {
            model.addAttribute("suc", false);
        } else {
            service.passSend(params.get("id"), params.get("email"));
            model.addAttribute("suc", true);
        }
        return "member/login/passFind/passFindForm";
    }

    //비밀번호찾기
    @RequestMapping(value = "/passFindForm")
    public String passFindForm(Model model) {
        return "member/login/passFind/passFindForm";
    }


    // 로그인 폼으로
    @RequestMapping(value = "/loginForm")
    public String loginForm(Model model) {
        return "member/login/loginForm";
    }

    // 동의 폼으로
    @RequestMapping(value = "/agreeForm")
    public String agreeForm(Model model) {
        return "member/join/agreeForm";
    }

    // 회원가입 폼으로
    @RequestMapping(value = "/joinForm")
    public String joinForm(Model model) {
        return "member/join/joinForm";
    }
    // 회원가입 /member/join


    @RequestMapping(value = "/login")
    public String login(Model model, HttpSession session, @RequestParam String inputId, @RequestParam String inputPass) {
        boolean result = false;
        String pw = service.login(inputId);
        if (pw != null) {
            BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
            result = encoder.matches(inputPass, pw);
            logger.info("결과 체크 " + result);
            if (result) {
                String check = service.adminCheck(inputId);
                session.setAttribute("admin", check);
                session.setAttribute("loginId", inputId);
                return "redirect:/";
            } else {
                model.addAttribute("suc", false);
                return "member/login/loginForm";
            }
        } else {
            model.addAttribute("suc", false);
            return "member/login/loginForm";
        }
    }

    @RequestMapping(value = "/join")
    public String join(Model model, HttpSession session, @RequestParam HashMap<String, String> map) {
        int suc = service.join(map);
        if (suc > 0) {
            return "member/join/joinResult";
        } else {
            model.addAttribute("suc", suc);
            return "member/join/joinForm";
        }
    }

    // 이거 내비두셈
    @RequestMapping(value = "/logout")
    public String logout(HttpSession session) throws Exception {
        session.removeAttribute("loginId");
        session.removeAttribute("admin");
        String access_token = (String) session.getAttribute("access_token");
        System.out.println(access_token);
        if (access_token != null) {
            // 요 라이브러리 추천 받음
            RestTemplate restTemplate = new RestTemplate();
            // 헤더 생성
            HttpHeaders headers = new HttpHeaders();
            // 헤더에 속성값 넣어주기
            headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
            headers.add("Authorization", "Bearer " + access_token);
            // 헤더랑 파라미터 담은녀석
            HttpEntity<MultiValueMap<String, String>> kakaoTokenRequest = new HttpEntity<>(headers);
            // response 받기
            ResponseEntity<String> response = restTemplate.exchange(
                    "https://kapi.kakao.com/v1/user/logout",
                    HttpMethod.POST,
                    kakaoTokenRequest,
                    String.class
            );
            System.out.println("카카오 로그아웃 성공 여부" + response.getBody().toString());
            session.removeAttribute("access_token");
        }
        return "redirect:/";
    }


}
