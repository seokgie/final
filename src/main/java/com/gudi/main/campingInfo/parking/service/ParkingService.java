package com.gudi.main.campingInfo.parking.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.main.campingInfo.parking.dao.ParkingMapper;
import com.gudi.main.dtoAll.CampingDTO;
import com.gudi.main.dtoAll.GoodDTO;
import com.gudi.main.dtoAll.ParkingDTO;
import com.gudi.main.util.HansolUtil;

@Service
public class ParkingService {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired ParkingMapper dao;
	
	public ArrayList<ParkingDTO> getZapyo(HashMap<String, Object> map) {
		
		String wido = (String) map.get("wido");
		String kyongdo = (String) map.get("kyongdo");
		
		System.out.println(wido + " / " + kyongdo);
		
		return dao.getZapyo(wido,kyongdo);
	}


	public ParkingDTO freeParkDetail(String prknum) {
		return dao.freeParkDetail(prknum);
	}

	public ArrayList<CampingDTO> payZapyo(HashMap<String, Object> map) {

		String wido = (String) map.get("wido");
		String kyongdo = (String) map.get("kyongdo");
		
		System.out.println(wido + " / " + kyongdo);
		
		return dao.payZapyo(wido,kyongdo);
		
	}

	public ArrayList<GoodDTO> callRank() {
		return dao.callRank();
	}


	public ArrayList<GoodDTO> callPayRank() {
		return dao.callPayRank();
	}


}
