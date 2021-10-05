package com.gudi.main.alarm.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gudi.main.alarm.service.AlarmService;

@RestController
@RequestMapping(value = "/alarm")
public class AlarmController {

    @Autowired
    AlarmService service;

    @RequestMapping(value = "/read")
    public HashMap<String, Object> alarmRead(String loginId) {
        HashMap<String, Object> map = null;
        if (loginId != null) {
            map = service.read(loginId);
        } else {
            map = new HashMap<String, Object>();
        }
        return map;
    }

    @RequestMapping(value = "/detail")
    public HashMap<String, Object> alarmDetail(@RequestParam HashMap<String, Object> param) {
        String loginId = (String) param.get("loginId");
        HashMap<String, Object> map = service.Detail(loginId);
        return map;
    }

    @RequestMapping(value = "/update")
    public HashMap<String, Object> alarmUpdate(@RequestParam String loginId) {
        HashMap<String, Object> map = service.Update(loginId);
        return map;
    }

}
