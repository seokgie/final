package com.gudi.main.cm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;

@RestController
@RequestMapping(value = "/cm")
public class CmRestController {
    @Autowired
    CmService cmService;

    @RequestMapping(value = "/cmInsert")
    public HashMap<String, Object> cmInsert(HttpSession session, String commentContent,
                                            String contentId, String division) {
        String loginId = (String) session.getAttribute("loginId");
        return cmService.cmInsert(contentId, commentContent, loginId, division);
    }

    @RequestMapping(value = "/cmUpdate")
    public HashMap<String, Object> cmUpdate(HttpSession session, String cmNum, String contentId,
                                            String cmUpdateContent, String division) {
        String loginId = (String) session.getAttribute("loginId");
        return cmService.cmUpdate(cmNum, contentId, cmUpdateContent, loginId, division);
    }

    @RequestMapping(value = "/cmList/{page}/{contentId}/{division}")
    public HashMap<String, Object> cmList(HttpSession session, @PathVariable int page,
                                          @PathVariable String contentId, @PathVariable String division) {
        String loginId = (String) session.getAttribute("loginId");
        HashMap<String, Object> map = cmService.cmList(contentId, division, page);
        map.put("loginId", loginId);
        return map;
    }

    @RequestMapping(value = "/cmDelete")
    public HashMap<String, Object> cmDelete(HttpSession session, String cmNum, String contentId, String division) {
        String loginId = (String) session.getAttribute("loginId");
        return cmService.cmDelete(cmNum, contentId, loginId, division);
    }
}
