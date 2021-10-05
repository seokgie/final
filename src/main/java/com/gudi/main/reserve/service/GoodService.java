package com.gudi.main.reserve.service;

import com.gudi.main.reserve.dao.GoodMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;

@Service
public class GoodService {
    @Autowired
    GoodMapper mapper;
    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Transactional
    public HashMap<String, Object> campingGood(String contentId, String loginId) {
        HashMap<String,Object> map = new HashMap<String, Object>();
        boolean result = false;
        String check = mapper.goodCheck(contentId, "camping", loginId);
        if (check == null) {
            mapper.goodInsert(contentId, "camping", loginId);
            result = true;
        } else {
            mapper.goodDelete(contentId, "camping", loginId);
        }
        int goodCount = mapper.goodCount(contentId, "camping");
        map.put("goodCheck",result);
        map.put("goodCount",goodCount);
        return map;
    }
}
