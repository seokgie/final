package com.gudi.main.myInfo.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import com.gudi.main.dtoAll.MemberDTO;
import com.gudi.main.myInfo.service.MyInfoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping(value = "/myInfo")
public class MyInfoController {
    Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    MyInfoService service;

    @RequestMapping(value = "/memberUpdate")
    public String myInfo(Model model, HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        MemberDTO dto = service.myInfoData(loginId);
        model.addAttribute("dto", dto);
        return "member/myInfo/information/memberUpdate";
    }

    @RequestMapping(value = "/infoUpdate")
    public String infoUpdate(HttpSession session, Model model, String nickName, RedirectAttributes redirect) {
        String loginId = (String) session.getAttribute("loginId");
        service.infoUpdate(nickName, loginId);
        return "redirect:/myInfo/memberUpdate";
    }

    @RequestMapping(value = "/memberPassChangeForm")
    public String memberPassChange() {
        return "member/myInfo/information/memberPassChangeForm";
    }

    @RequestMapping(value = "/passChange")
    public String passChange(HttpSession session, Model model, String pw, String pwChange) {
        boolean result = false;
        String loginId = (String) session.getAttribute("loginId");
        String pass = service.pwCheck(loginId);
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        result = encoder.matches(pw, pass);
        if (result) {
            service.pwUpdate(pwChange, loginId);
            return "redirect:/member/logout";
        } else {
            model.addAttribute("suc", false);
            return "member/myInfo/information/memberPassChangeForm";
        }
    }

    @RequestMapping(value = "/memberDrop")
    public String memberDrop() {
        return "member/myInfo/information/memberDrop";
    }

    @RequestMapping(value = "/memberDropReal")
    public String memberDropReal(HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        service.memberDropReal(loginId);
        return "redirect:/member/logout";
    }

    @RequestMapping(value = "/campingClear")
    public String campingClear() {
        return "member/myInfo/list/campingClear";
    }

    @RequestMapping(value = "/boardList/{page}/{division}")
    public String boardList(@PathVariable int page, @PathVariable String division, HttpSession session, Model model) {
        String loginId = (String) session.getAttribute("loginId");
        HashMap<String, Object> map = service.reviewList(loginId, page, division);
        model.addAttribute("map", map);
        if (division.equals("reviewBoard")) {
            return "member/myInfo/list/boardList/reviewBoard";
        } else if (division.equals("freeBoard")) {
            return "member/myInfo/list/boardList/freeBoard";
        } else if (division.equals("noticeBoard")) {
            return "member/myInfo/list/boardList/noticeBoard";
        } else {
            return "member/myInfo/list/boardList/questionBoard";
        }
    }

    @RequestMapping(value = "/cmList/{page}/{division}")
    public String comment(HttpSession session, Model model, @PathVariable int page, @PathVariable String division) {
        String loginId = (String) session.getAttribute("loginId");
        HashMap<String, Object> map = service.myCmList(loginId, page, division);
        model.addAttribute("map", map);
        if (division.equals("review")) {
            return "member/myInfo/list/cmList/reviewCm";
        } else if (division.equals("free")) {
            return "member/myInfo/list/cmList/freeCm";
        } else if (division.equals("notice")) {
            return "member/myInfo/list/cmList/noticeCm";
        } else if (division.equals("question")) {
            return "member/myInfo/list/cmList/questionCm";
        } else if (division.equals("camping")) {
            return "member/myInfo/list/cmList/campingCm";
        } else {
            return "member/myInfo/list/cmList/carCm";
        }
    }

    @RequestMapping(value = "/wantToGo/{page}")
    public String wantToGo(@PathVariable int page, HttpSession session, Model model) {
        String loginId = (String) session.getAttribute("loginId");
        HashMap<String, Object> map = service.wantToGo(loginId, page);
        model.addAttribute("map", map);
        return "member/myInfo/list/wantToGo";
    }

    @RequestMapping(value = "/reserveCheck/{page}")
    public String reserveCheck(Model model, HttpSession session, @PathVariable int page) {
        String loginId = (String) session.getAttribute("loginId");
        HashMap<String, Object> map = service.reserveList(loginId, page);
        model.addAttribute("map", map);
        return "member/myInfo/reserve/reserveCheck";
    }

    @RequestMapping(value = "/reserveCancel/{reserveNum}")
    public String reserveCancel(@PathVariable int reserveNum) {
        service.reserveCancel(reserveNum);
        return "redirect:/myInfo/reserveCheck/1";
    }

    @RequestMapping(value = "/reportCmList/{page}")
    public String reportCmList(@PathVariable int page, Model model, HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        HashMap<String, Object> map = service.reportCmList(page, loginId);
        model.addAttribute("map", map);
        return "member/myInfo/list/cmList/reportCm";
    }
}
