package com.gudi.main.campingInfo.parking.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.main.campingInfo.parking.dao.ParkingMapper;
import com.gudi.main.campingInfo.parking.service.ParkingService;
import com.gudi.main.cm.CmService;
import com.gudi.main.dtoAll.CampingDTO;
import com.gudi.main.dtoAll.GoodDTO;
import com.gudi.main.dtoAll.ParkingDTO;
import com.gudi.main.reserve.dao.GoodMapper;

@Controller
@RequestMapping(value = "/campingInfo")
public class ParkingController {
    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired ParkingService service;
    @Autowired CmService cmService;
    @Autowired GoodMapper goodMapper;
    @Autowired ParkingMapper prkMapper;
    
    @RequestMapping(value = "/campingParking")
    public ModelAndView campingParking() {
    	logger.info("차박지도 메인 불러오셈::");
    	ModelAndView mav = new ModelAndView();
    	
    	//차트에 표시할 순위 불러오기
    	ArrayList<GoodDTO> rank = service.callRank(); //divisionnum, cnt
    	logger.info("rank 형태확인:: "+rank.size());
    	
    	String[] prkNames = new String[7];
    	String prkName = null;
    	
    	//디비전넘으로 주차장명 받아오기
    	for (int i = 0; i < rank.size(); i++) {
    		prkName = prkMapper.searchPrkName(rank.get(i).getDivisionNum());
    		prkNames[i] = prkName;
		}
    	System.out.println("prkNames:: "+prkNames[0]+" / "+prkNames[1]+" / "+prkNames[2]+" / "+prkNames[3]+" / "+prkNames[4]+" / "+prkNames[5]);
    	
    	/*
    	ArrayList<ParkingDTO> tag = service.badaTag();
    	mav.addObject("tags", tag);
    	*/
    	
    	mav.addObject("rank", rank);
    	mav.addObject("prkNames", prkNames);
    	mav.setViewName("campingInfo/campingParking/campingParkingMain");
    	
        return mav;
    }
    

    @RequestMapping(value = "/getZapyo")
    @ResponseBody
    public ArrayList<ParkingDTO> getZapyo(@RequestParam HashMap<String, Object> map) {
    	
    	System.out.println("넘어온 좌표는??::"+map); //{wido=36.499425535542095, kyongdo=127.66112788120117}
    	
    	ArrayList<ParkingDTO> dto = service.getZapyo(map);
    	
    	System.out.println("dto는??:: "+dto);
    	//ArrayList<ParkingDTO> dto = [class(key=value),class(key=value)]
    	System.out.println("dto 사이즈는??:: "+dto.size());
    	System.out.println(dto.get(0).getLatitude());
    	System.out.println(dto.get(0).getLongitude());
    	
        return dto;
    }
    
    @RequestMapping(value = "/freeParkDetail/{prknum}")
    @ResponseBody
    public ModelAndView freeParkDetail (@PathVariable String prknum, HttpSession session) {
    	String loginId = (String) session.getAttribute("loginId");
    	logger.info("차박지도 상세보기:: "+ prknum);
    	
    	ModelAndView mav = new ModelAndView();
    	
    	//주차장 상세정보
    	ParkingDTO dto = service.freeParkDetail(prknum);
    	
    	//댓글 불러옴
	    HashMap<String, Object> map = cmService.cmList(prknum,"parking", 1);
	    
	    //총 추천수 불러옴
    	map.put("goodCount",goodMapper.goodCount(prknum,"parking"));
    	
    	//내가 추천했는지 체크
    	String check = null;
    	if(loginId != null) {
    		check = goodMapper.goodCheck(prknum, "parking", loginId);
    	}
    	if (check == null) { 
            map.put("goodCheck", false);
        } else { 
            map.put("goodCheck", true);
        }
	    
    	mav.addObject("map",map);
    	mav.addObject("dto",dto);
    	mav.setViewName("/campingInfo/campingParking/freeParkDetail");
        
    	return mav;
    }
    
    
    @RequestMapping(value = "/payPark")
    public ModelAndView payPark(Model model) {
    	logger.info("차박 유료지도 메인 불러오셈::");
    	ModelAndView mav = new ModelAndView();
    	
    	//차트에 표시할 순위 불러오기
    	ArrayList<GoodDTO> rank = service.callPayRank(); //divisionnum, cnt
    	logger.info("rank 형태확인:: "+rank.size());
    	
    	String[] prkNames = new String[7];
    	String prkName = null;
    	
    	//디비전넘으로 주차장명 받아오기
    	for (int i = 0; i < rank.size(); i++) {
    		prkName = prkMapper.searchPayPrkName(rank.get(i).getDivisionNum());
    		prkNames[i] = prkName;
		}
    	System.out.println("prkNames:: "+prkNames[0]+" / "+prkNames[1]+" / "+prkNames[2]+" / "+prkNames[3]+" / "+prkNames[4]+" / "+prkNames[5]);
    	
    	/*
    	ArrayList<ParkingDTO> tag = service.badaTag();
    	mav.addObject("tags", tag);
    	*/
    	
    	mav.addObject("rank", rank);
    	mav.addObject("prkNames", prkNames);
    	mav.setViewName("campingInfo/campingParking/payParkingMain");
    	
        return mav;
    }
    
    @RequestMapping(value = "/payZapyo")
    @ResponseBody
    public ArrayList<CampingDTO> payZapyo(@RequestParam HashMap<String, Object> map) {
    	logger.info("차박 유료지도 메인 불러오셈::");
    	System.out.println("넘어온 좌표는??::"+map); //{wido=36.499425535542095, kyongdo=127.66112788120117}
    	
    	ArrayList<CampingDTO> dto = service.payZapyo(map);
    	//mapX 가 위도 mapY 가 경도
    	
    	System.out.println("dto는??:: "+dto);
    	System.out.println("dto 사이즈는??:: "+dto.size());
    	
    	System.out.println(dto.get(0).getMapX()); //위도
    	System.out.println(dto.get(0).getMapY()); //경도
    	
        return dto;
    }
    
    

    
    /*
    @RequestMapping(value = "/apiCall")
    @ResponseBody
    public void apiCall(
    		@RequestParam HashMap<String, String> params) {
    	System.out.println("db작업확인???:::");
        service.apiCall(params);
    }
	*/

}
