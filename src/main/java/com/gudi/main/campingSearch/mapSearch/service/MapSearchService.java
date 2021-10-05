package com.gudi.main.campingSearch.mapSearch.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gudi.main.campingSearch.mapSearch.dao.MapSearchMapper;
import com.gudi.main.dtoAll.CampingDTO;
import com.gudi.main.dtoAll.ParkingDTO;
import com.gudi.main.util.HansolUtil;

@Service
public class MapSearchService {
	  Logger logger = LoggerFactory.getLogger(this.getClass());
	    
	    @Autowired MapSearchMapper dao;
	

	public HashMap<String, Object> list(int page, String word, String type) {
		//int total = dao.allCount();
		if(type.equals("addr")) {
			type="addr1";
		}else {
			type="facltNm";
		}
		int total = dao.total(word,type);
		HashMap<String, Object> map = new HansolUtil().pagination(page,10, total);
		//1.list
		if (page == 1) {
			page = 0;
		} else {
			page = (page - 1) * 10;
		}
		ArrayList<CampingDTO> list = dao.list(page, word,10,type);
		map.put("list", list);
		
		return map;
	}


	public ArrayList<CampingDTO> zapyo(HashMap<String, Object> map) {
			
			String wido = (String) map.get("wido");//mapY
			String kyongdo = (String) map.get("kyongdo");//mapX
			System.out.println(wido + " / " + kyongdo);
			return dao.zapyo(wido,kyongdo);
		}
}
