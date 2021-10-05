package com.gudi.main.mainPage;

import com.gudi.main.dtoAll.CampingDTO;
import com.gudi.main.util.UploadUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;

@Controller
public class MainController {
    Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    MainService service;
    @Autowired
    MainApiData mainApiData;

    @RequestMapping(value = "/")
    public String main(HttpSession session, Model model) {
        session.setAttribute("access_token", null);
        HashMap<String, Object> map = service.list();
        model.addAttribute("map", map);
        return "main";
    }

    @RequestMapping(value = "/exp")
    public String exp(HttpSession session, Model model) {
        return "exception/error";
    }

    @ResponseBody
    @RequestMapping(value = "/MainPageNation/{page}/{location}")
    public HashMap<String, Object> MainPageNation(HttpSession session, @PathVariable int page, @PathVariable String location) {
        System.out.println(page + " " + location);
        return service.pageList(page, location);
    }

}
