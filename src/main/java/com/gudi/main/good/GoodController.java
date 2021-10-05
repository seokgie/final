package com.gudi.main.good;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;

@RestController
@RequestMapping(value = "/good")
public class GoodController {
    @Autowired GoodServiceCommon service;

    @RequestMapping(value = "/goodData")
    public HashMap<String, Object> goodData(HttpSession session, String contentId,String division) throws Exception {
        String loginId = (String) session.getAttribute("loginId");
        if (session.getAttribute("loginId") == null) {
            return new HashMap<String, Object>();
        } else {
            return service.goodData(contentId, loginId,division);
        }

    }
}
