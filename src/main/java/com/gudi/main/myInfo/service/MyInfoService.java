package com.gudi.main.myInfo.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.gudi.main.dtoAll.*;
import com.gudi.main.myInfo.dto.MyInfoDTO;
import com.gudi.main.util.HansolUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.main.myInfo.dao.MyInfoMapper;

@Service
public class MyInfoService {
    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    MyInfoMapper dao;

    public MemberDTO myInfoData(String loginId) {
        MemberDTO dto = dao.myInfoData(loginId);
        return dto;
    }

    public void infoUpdate(String nickName, String loginId) {
        dao.infoUpdate(loginId, nickName);
    }

    public String pwCheck(String loginId) {
        return dao.pwCheck(loginId);
    }

    public void pwUpdate(String pwChange, String loginId) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String enc_pass = encoder.encode(pwChange);
        dao.pwUpdate(enc_pass, loginId);
    }

    public void memberDropReal(String loginId) {
        dao.memberDropReal(loginId);
    }

    public HashMap<String, Object> reserveList(String loginId, int page) {
        int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        int total = dao.reserveTotal(loginId);
        HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);

        ArrayList<MyInfoDTO> list = dao.reserveList(loginId, start);
        map.put("list", list);
        return map;
    }

    public void reserveCancel(int reserveNum) {
        dao.reserveCancel(reserveNum);
    }

    public HashMap<String, Object> myCmList(String loginId, int page, String division) {
        int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        int total = dao.myCmTotal(loginId, division);
        ArrayList<CommentDTO> list = dao.myCmList(loginId, start, division);
        HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);
        map.put("list", list);
        return map;
    }

    public HashMap<String, Object> reviewList(String loginId, int page, String division) {
        int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        int total = dao.myBoardTotal(loginId, division);
        ArrayList<BoardDTO> list = dao.reviewList(loginId, start, division);
        HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);
        map.put("list", list);
        return map;
    }

    public HashMap<String, Object> wantToGo(String loginId, int page) {
        int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        int total = dao.wantToGoTotal(loginId);
        ArrayList<CampingDTO> list = dao.wantToGoCampingList(loginId, start);
        HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);
        map.put("list", list);
        return map;

    }

    public HashMap<String, Object> reportCmList(int page, String loginId) {
        int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        int total = dao.reportCmTotal(loginId);
        ArrayList<CommentReportDTO> list = dao.reportCmList(loginId, start);
        HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);
        map.put("list",list);
        return map;
    }
}
