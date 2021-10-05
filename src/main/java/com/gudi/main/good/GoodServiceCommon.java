package com.gudi.main.good;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gudi.main.alarm.dao.AlarmMapper;

@Service
public class GoodServiceCommon {
    @Autowired
    GoodMapperCommon mapper;
    @Autowired
    AlarmMapper alarm;


    public HashMap<String, Object> goodData(String contentId, String loginId, String division) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        boolean result = false;
        String check = mapper.goodCheck(contentId, division, loginId);
        String good = "good";
        if (check == null) {
            mapper.goodInsert(contentId, division, loginId);
            if (!division.equals("parking")) {
                alarm.insert(loginId, contentId, division, good);
            }
            result = true;
        } else {
            mapper.goodDelete(contentId, division, loginId);
            if (!division.equals("parking")) {
                alarm.goodDelete(contentId, division, loginId);
            }
        }
        int goodCount = mapper.goodCount(contentId, division);
        map.put("goodCheck", result);
        map.put("goodCount", goodCount);
        return map;
    }
}
