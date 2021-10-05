package com.gudi.main.reserve.service;

import com.gudi.main.dtoAll.CommentDTO;
import com.gudi.main.reserve.dao.CommentMapper;
import com.gudi.main.reserve.dao.ReserveMapper;
import com.gudi.main.util.HansolUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;

@Service
public class CommentService {
    @Autowired
    CommentMapper commentMapper;
    Logger logger = LoggerFactory.getLogger(this.getClass());

    // 해당 댓글리스트 가져오기
    @Transactional
    public HashMap<String, Object> commentList(String contentId, String division, int page) {
        int start = 0;
        if (page != 1) {
            start = (page - 1) * 8;
        }
        ArrayList<CommentDTO> commentList = commentMapper.cmList(contentId, division, start);
        int total = commentMapper.reserveTotal(contentId);
        HashMap<String, Object> map = HansolUtil.pagination(page, 8, total);
        map.put("commentList", commentList);
        return map;
    }

    // 댓글 작성하기
    @Transactional
    public HashMap<String, Object> reserveCmInsert(String contentId, String commentContent, String loginId) {
        // 댓글 인서트
        int suc = commentMapper.reserveCmInsert(loginId, commentContent, contentId);
        // 리스트 뿌려주기
        HashMap<String, Object> map = commentList(contentId, "camping", 1);
        map.put("loginId", loginId);
        return map;
    }

    // 댓글 수정
    @Transactional
    public HashMap<String, Object> reserveCmUpdate(String cmNum, String contentId, String cmUpdateContent, String loginId) {
        // 댓글 업데이트
        commentMapper.reserveCmUpdate(cmNum, cmUpdateContent);
        int page = cmPageCheck(contentId, "camping", Integer.parseInt(cmNum));
        System.out.println("page 는 뭐냐 : " + page);
        HashMap<String, Object> map = commentList(contentId, "camping", page);

        map.put("loginId", loginId);
        return map;
    }


    public int cmPageCheck(String contentId, String division, int cmNum) {
        int page = 1;
        int start = 0;
        while (true) {
            start = (page - 1) * 8;
            String find = commentMapper.cmPageCheck(contentId, division, cmNum, start);
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
    public HashMap<String, Object> reserveCmDelete(String cmNum, String contentId, String loginId) {
        int page = cmPageCheck(contentId, "camping", Integer.parseInt(cmNum));
        System.out.println("이거 뭐야 " + page);
        commentMapper.cmDelete(cmNum);
        HashMap<String, Object> map = commentList(contentId, "camping", page);
        System.out.println("이거 뭐야 " + map);
        ArrayList<CommentDTO> cmList = (ArrayList<CommentDTO>) map.get("commentList");
        if (cmList.size() < 1 && page != 1) {
            map = commentList(contentId, "camping", page - 1);
        }
        map.put("loginId", loginId);
        System.out.println("여기 뭐 들어 있냐" + map);
        return map;
    }
}
