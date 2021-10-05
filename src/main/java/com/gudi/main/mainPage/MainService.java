package com.gudi.main.mainPage;

import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.dtoAll.CampingDTO;
import com.gudi.main.util.ApiUtil;
import com.gudi.main.util.HansolUtil;
import com.gudi.main.util.UploadUtil;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

@Service
public class MainService {
    Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    MainMapper mapper;

    @Transactional
    public HashMap<String, Object> list() {
        int total = mapper.total("경기");
        HashMap<String, Object> map = HansolUtil.pagination(1, 6, total);
        ArrayList<CampingDTO> list = mapper.locationList("경기", 0);
        Calendar cal = Calendar.getInstance();
        int month = cal.get(Calendar.MONTH) + 1;
        ArrayList<MainDTO> goodList = mapper.goodList(month);
        ArrayList<BoardDTO> reviewBoardList = mapper.BoardList("reviewBoard");
        ArrayList<BoardDTO> freeBoardList = mapper.BoardList("freeBoard");
        ArrayList<BoardDTO> questionBoardList = mapper.BoardList("questionBoard");
        ArrayList<BoardDTO> noticeBoardList = mapper.BoardList("noticeBoard");
        map.put("reviewBoardList", reviewBoardList);
        map.put("freeBoardList", freeBoardList);
        map.put("questionBoardList", questionBoardList);
        map.put("noticeBoardList", noticeBoardList);
        map.put("list", list);
        map.put("location", "경기");
        map.put("goodList", goodList);
        return map;
    }

    @Transactional
    public HashMap<String, Object> pageList(int page, String location) {
        int total = mapper.total(location);
        HashMap<String, Object> map = HansolUtil.pagination(page, 6, total);
        int start = 0;
        if (page != 1) {
            start = (page - 1) * 6;
        }
        ArrayList<CampingDTO> list = mapper.locationList(location, start);
        map.put("list", list);
        map.put("location", location);
        return map;
    }

}
