package com.gudi.main.member.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.gudi.main.member.dao.MemberMapper;
import com.gudi.main.dtoAll.MemberDTO;

import javax.mail.internet.MimeMessage;

@Service
public class MemberService {
    Logger logger = LoggerFactory.getLogger(this.getClass());


    @Autowired
    MemberMapper mapper;
    @Autowired
    JavaMailSender sender;

    public int join(HashMap<String, String> map) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String enc_pass = encoder.encode(map.get("pw"));
        map.put("pw", enc_pass);
        return mapper.join(map);
    }


    public String idCheck(String id) {
        return mapper.idCheck(id);
    }

    public String login(String inputId) {
        return mapper.login(inputId);
    }


    public ArrayList<String> idFind(HashMap<String, String> params) {
        ArrayList<String> list = mapper.idFind(params);
        return list;
    }


    public String passFind(HashMap<String, String> params) {
        return mapper.passFind(params);
    }

    public void passSend(String id, String email) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        Random random = new Random();
        String emailCheckNum = Integer.toString(random.nextInt(888888) + 111111);
        String enc_pass = encoder.encode(emailCheckNum);
        mapper.passChange(enc_pass, id);
        /* 이메일 보내기 */
        String setFrom = "qkrgks456@gmail.com";
        String toMail = email;
        String title = "비밀번호찾기 알림 메일";
        String content =
                "홈페이지를 방문해주셔서 감사합니다." +
                        "<br><br>" +
                        "바뀐 비밀번호는 " + emailCheckNum + "입니다." +
                        "<br>" +
                        "로그인후 비밀번호를 변경해주세요!";
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
        }
    }

    public String adminCheck(String inputId) {
        return mapper.adminCheck(inputId);
    }
}
