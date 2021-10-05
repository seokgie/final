package com.gudi.main.campingSearch.mapSearch.controller;

import java.util.ArrayList;
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

import com.gudi.main.campingSearch.mapSearch.service.MapSearchService;
import com.gudi.main.dtoAll.CampingDTO;

@Controller
@RequestMapping(value = "/campingSearch")
public class MapSearchController {
    Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Autowired MapSearchService service;

    @RequestMapping(value = "/mapSearch")
    public String mapSearch(Model model) {
        return "campingSearch/mapSearch/mapSearchMain";
    }
    
    @ResponseBody
    @RequestMapping(value="/mapSearchList/{page}")
	public HashMap<String, Object> mapSearchList( @PathVariable int page,@RequestParam HashMap<String, Object> param){
    	String word = (String) param.get("word");
    	String type = (String) param.get("type");
    	System.out.println(page+"페이지 / 검색어는 ? "+word+" 타입은?"+type);
		HashMap<String, Object> map =  service.list(page, word, type);
		return map;
	}
    
    @RequestMapping(value = "/zapyo")
    @ResponseBody
    public ArrayList<CampingDTO> zapyo(@RequestParam HashMap<String, Object> map) {
    	
    	System.out.println("넘어온 좌표는?:"+map); //{wido=36.499425535542095, kyongdo=127.66112788120117}
    	
    	ArrayList<CampingDTO> dto = service.zapyo(map);
    	
    	System.out.println("dto 사이즈는?: "+dto.size());
        return dto;
    }
}
