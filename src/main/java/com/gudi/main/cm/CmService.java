package com.gudi.main.cm;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gudi.main.alarm.dao.AlarmMapper;
import com.gudi.main.dtoAll.CommentDTO;
import com.gudi.main.util.HansolUtil;

@Service
public class CmService {
    @Autowired
    CmMapper cmMapper;
    @Autowired
    AlarmMapper alarm;

    // 해당 댓글리스트 가져오기
    @Transactional
    public HashMap<String, Object> cmList(String contentId, String division, int page) {
        int start = 0;
        if (page != 1) {
            start = (page - 1) * 8;
        }
        ArrayList<CommentDTO> cmList = cmMapper.cmList(contentId, division, start);
        int total = cmMapper.cmTotal(contentId, division);
        HashMap<String, Object> map = HansolUtil.pagination(page, 8, total);
        map.put("cmList", cmList);
        return map;
    }

    // 댓글 작성하기
    @Transactional
    public HashMap<String, Object> cmInsert(String contentId, String commentContent, String loginId, String division) {
        // 댓글 인서트
        int suc = cmMapper.cmInsert(loginId, commentContent, contentId, division);
        // 알람 인서트
        String cm = "cm";
        if (!division.equals("parking")) {
            alarm.insert(loginId, contentId, division, cm);
        }
        // 리스트 뿌려주기
        HashMap<String, Object> map = cmList(contentId, division, 1);
        map.put("loginId", loginId);
        return map;
    }

    // 댓글 수정
    @Transactional
    public HashMap<String, Object> cmUpdate(String cmNum, String contentId, String cmUpdateContent, String loginId, String division) {
        // 댓글 업데이트
        cmMapper.cmUpdate(cmNum, cmUpdateContent);
        int page = cmPageCheck(contentId, division, Integer.parseInt(cmNum));
        HashMap<String, Object> map = cmList(contentId, division, page);
        map.put("loginId", loginId);
        return map;
    }


    public int cmPageCheck(String contentId, String division, int cmNum) {
        int page = 1;
        int start = 0;
        while (true) {
            start = (page - 1) * 8;
            String find = cmMapper.cmPageCheck(contentId, division, cmNum, start);
            System.out.println(find);
            if (find != null) {
                break;
            } else {
                page++;
            }
        }
        return page;
    }

    @Transactional
    public HashMap<String, Object> cmDelete(String cmNum, String contentId, String loginId, String division) {
        int page = cmPageCheck(contentId, division, Integer.parseInt(cmNum));
        cmMapper.cmDelete(cmNum);
        HashMap<String, Object> map = cmList(contentId, division, page);
        ArrayList<CommentDTO> cmList = (ArrayList<CommentDTO>) map.get("cmList");
        if (cmList.size() < 1 && page != 1) {
            map = cmList(contentId, division, page - 1);
        }
        map.put("loginId", loginId);
        return map;
    }

    public void cmReport(HashMap<String, String> params) {
        cmMapper.cmReport(params);
    }
}
