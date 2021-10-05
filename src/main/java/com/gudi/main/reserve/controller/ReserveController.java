package com.gudi.main.reserve.controller;

import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.dtoAll.CampingDTO;
import com.gudi.main.dtoAll.ReserveDTO;
import com.gudi.main.reserve.service.ReserveService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;

@Controller
@RequestMapping(value = "/reserve")
public class ReserveController {
    Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    ReserveService service;

    @RequestMapping(value = "/campingDetail/{contentId}")
    public String myInfo(Model model, @PathVariable String contentId, HttpSession session) {
        HashMap<String, Object> map = service.campingDetail(contentId, session);
        model.addAttribute("map", map);
        return "reserve/campingDetail";
    }

    @RequestMapping(value = "/campingReserveForm/{contentId}")
    public String campingReserveForm(@PathVariable String contentId, Model model) {
        model.addAttribute("contentId", contentId);
        return "reserve/campingReserveForm";
    }

    @RequestMapping(value = "/campingReserve/{contentId}")
    public String campingReserve(@PathVariable String contentId, @RequestParam HashMap<String, String> params, HttpSession session) {
        String loginId = (String) session.getAttribute("loginId");
        service.campingReserveInsert(params, loginId, contentId);
        return "reserve/campingResult";
    }

}
