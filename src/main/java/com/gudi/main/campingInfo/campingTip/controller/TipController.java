package com.gudi.main.campingInfo.campingTip.controller;

import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gudi.main.campingInfo.campingTip.service.TipService;

@Controller
@RequestMapping(value = "/campingInfo")
public class TipController {
    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    TipService service;


    @RequestMapping(value = "/campingTip")
    public String campingTip(Model model) {
        return "campingInfo/campingTip";
    }


    @ResponseBody
    @RequestMapping(value = "/campingApi/{page}")
    public HashMap<String, Object> campingApi(@PathVariable String page) {
        System.out.println("몇페이지?" + page);
        return service.Api(page);
    }


}
