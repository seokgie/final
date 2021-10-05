package com.gudi.main.alarm.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gudi.main.alarm.dao.AlarmMapper;
import com.gudi.main.dtoAll.AlarmDTO;

@Service
public class AlarmService {

    @Autowired
    AlarmMapper dao;

    public HashMap<String, Object> read(String loginId) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        ArrayList<AlarmDTO> list = dao.read(loginId);
        map.put("list", list);
        return map;
    }

    public HashMap<String, Object> Detail(String loginId) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        ArrayList<AlarmDTO> list = dao.detail(loginId);
        map.put("list", list);
        return map;
    }

    public HashMap<String, Object> Update(String loginId) {
        HashMap<String, Object> map = new HashMap<String, Object>();
        boolean suc = dao.update(loginId);
        map.put("suc", suc);
        return map;
    }


}
