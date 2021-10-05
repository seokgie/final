package com.gudi.main.member.controller;

import com.gudi.main.member.service.MemberService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import java.util.Random;

@RestController
@RequestMapping(value = "/member")
public class MemberRestController {
    Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    MemberService service;
    @Autowired
    JavaMailSender sender;

    @RequestMapping(value = "/idCheck")
    public boolean idCheck(Model model, String id) {
        String idCheck = service.idCheck(id);
        boolean result = false;
        if (idCheck == null) {
            result = true;
        }
        return result;
    }

    // 이메일 인증 번호 발사
    @RequestMapping(value = "/emailCheck")
    public boolean emailCheck(Model model, String email, HttpSession session) {
        boolean suc = true;
        // 난수
        Random random = new Random();
        String emailCheckNum = Integer.toString(random.nextInt(888888) + 111111);
        session.setAttribute("emailCheckNum", emailCheckNum);
        /* 이메일 보내기 */
        String setFrom = "qkrgks456@gmail.com";
        String toMail = email;
        String title = "회원가입 인증 이메일 입니다.";
        String content =
                "홈페이지를 방문해주셔서 감사합니다." +
                        "<br><br>" +
                        "인증 번호는 " + emailCheckNum + "입니다." +
                        "<br>" +
                        "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
        try {
            MimeMessage message = sender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
            helper.setFrom(setFrom);
            helper.setTo(toMail);
            helper.setSubject(title);
            helper.setText(content, true);
            sender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
            suc = false;
        }
        return suc;
    }

    @RequestMapping(value = "/codeCheck")
    public boolean codeCheck(Model model, String code, HttpSession session) {
        boolean result = false;
        String emailCheckNum = (String) session.getAttribute("emailCheckNum");
        if (emailCheckNum.equals(code)) {
            result = true;
        }
        return result;
    }
}
