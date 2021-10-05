package com.gudi.main.cm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.HashMap;

@Controller
@RequestMapping(value = "/cm")
public class CmReportController {

    @Autowired
    CmService service;

    @RequestMapping(value = "/cmReportForm/{cmNum}")
    public String cmReportForm(@PathVariable String cmNum, Model model) {
        model.addAttribute("cmNum", cmNum);
        return "fix/cmReportForm";
    }

    @RequestMapping(value = "/cmReport")
    public String cmReport(Model model, @RequestParam HashMap<String, String> params) {
        service.cmReport(params);
        return "redirect:/myInfo/reportCmList/1";
    }
}
