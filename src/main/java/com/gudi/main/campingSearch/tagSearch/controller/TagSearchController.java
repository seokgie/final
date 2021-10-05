package com.gudi.main.campingSearch.tagSearch.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.main.campingSearch.tagSearch.service.TagSearchService;

@Controller
@RequestMapping(value = "/campingSearch")
public class TagSearchController {
    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired TagSearchService service;
    
    @RequestMapping(value = "/tagSearch/{page}")
    public ModelAndView tagSearch(@PathVariable int page) {
        	return service.lists(page);
    }
    
    @RequestMapping(value = "/search/{page}")
    public ModelAndView Search(@PathVariable int page, @RequestParam String word) { 
       // System.out.println(word+"검색창");
        return service.search(page, word);	
    }
    
    @RequestMapping(value = "/search/{page}/{word}")
    public ModelAndView SearchP(@PathVariable int page,@PathVariable String word) {
    	logger.info("검색입력 :"+word+page+"페이지");
        	return service.search(page,word);
    }
}
