package com.gudi.main.campingTalk.freeBoard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.main.campingTalk.freeBoard.dao.FreeMapper;
import com.gudi.main.campingTalk.freeBoard.service.FreeService;
import com.gudi.main.cm.CmService;
import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.dtoAll.PhotoDTO;
import com.gudi.main.good.GoodMapperCommon;

@Controller
@RequestMapping(value = "/campingTalk")
public class FreeController {
	
    Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired FreeService service;
    @Autowired CmService cmService;
    @Autowired GoodMapperCommon goodMapperCm;
    @Autowired FreeMapper mapper;
    
    // 글 목록 불러오기
    @RequestMapping(value = "/freeBoard")
    public ModelAndView freeBoard() {
    	
    	int page = 1;
    	
    	logger.info("리스트 요청");
    	
    	return service.freeList(page);
    }
    
    // 페이징 처리
    @RequestMapping(value = "/freeBoard/{page}")
    public ModelAndView reviewBoard(@PathVariable int page) {
    	logger.info("게시글 리스트 확인 페이지 수 : " + page);	
        return service.freeList(page);
    }
    
    // 글 쓰기 폼 부분
    @RequestMapping(value = "/freeWriteForm")
    public String freeWriteForm(Model model) {
    	logger.info("글쓰기폼 요청");
        return "campingTalk/freeBoard/freeWriteForm";
    }
    
    // 글쓰기 
    @Transactional(isolation = Isolation.READ_COMMITTED)
    @RequestMapping(value = "/freeWrite")
    public ModelAndView freeWrite(@RequestParam HashMap<String, String> params,
    		MultipartFile[] file, HttpSession session) {
    	
    	String loginId = (String)session.getAttribute("loginId");
    	params.put("loginId", loginId);
    	
    	logger.info("글쓰기 요청");
    	
    	ModelAndView mav = new ModelAndView();
    	
    	// 글 쓰기 부분
    	service.freeWrite(params);
    	String boardNum = String.valueOf(params.get("boardnum"));
    	System.out.println("boardNum : " + boardNum);
    	// 파일업로드 부분
    	service.freePhoto(file, boardNum);
    	
    	mav.setViewName("redirect:./freeDetail/"+boardNum);
     	
        return mav;
    }
    
    // 상세보기
    @Transactional(isolation = Isolation.READ_COMMITTED)
    @RequestMapping(value = "/freeDetail/{boardNum}")
    public ModelAndView freeDetail(@PathVariable int boardNum, HttpSession session) {
    	String loginId = (String)session.getAttribute("loginId");
    	
    	logger.info("상세보기 요청");
    	logger.info("boardNum : " + boardNum);
    	
    	ModelAndView mav = new ModelAndView();
    	
    	//사진 불러오기(여러개 가능)
    	ArrayList<PhotoDTO> phoDto = service.callPhoto(boardNum);
    	
    	//글 가져오기
    	BoardDTO dto = service.freeDetail(boardNum);
    	
    	//조회수 올리기
    	service.freeHit(boardNum);
    	
    	//댓글 불러옴
    	HashMap<String,Object> map = cmService.cmList(Integer.toString(boardNum), "free", 1);
    	
    	//좋아요 불러옴
    	map.put("goodCount",goodMapperCm.goodCount(Integer.toString(boardNum), "free"));
    	String check = null;
    	if(loginId != null) {
    		check = goodMapperCm.goodCheck(Integer.toString(boardNum), "free", loginId);
    	}
    	if (check == null) {
            map.put("goodCheck", false);
        } else {
            map.put("goodCheck", true);
        }
    	
    	mav.setViewName("campingTalk/freeBoard/freeDetail");
    	mav.addObject("dto",dto);
    	mav.addObject("phoDtos",phoDto);
    	mav.addObject("map", map);

        return mav;
    }
    
    // 글 삭제
    @RequestMapping(value = "/freeDel/{boardNum}")
    public String freeDel(@PathVariable int boardNum, Model model) {
    	logger.info("글 삭제");
    	logger.info("boardNum : " + boardNum);
    	
    	int suc = service.freeDel(boardNum);
    	if (suc>0) {
    		String delMsg = "글이 삭제되었습니다.";
			model.addAttribute("delMsg",delMsg);
		}
    	
        return "redirect:../freeBoard";
    }
    
    // 글 수정폼
    @RequestMapping(value = "/freeUpdateForm/{boardNum}")
    public ModelAndView freeUpdateForm(@PathVariable int boardNum) {
    	logger.info("글 수정폼 요청");
    	logger.info("boardNum : " + boardNum);
    	
    	ModelAndView mav = new ModelAndView();
    	
    	//사진 불러오기
    	ArrayList<PhotoDTO> phoDto = service.callPhoto(boardNum);
    	
    	//글 불러옴
    	BoardDTO dto = service.freeDetail(boardNum);
    	mav.setViewName("campingTalk/freeBoard/freeUpdateForm");
    	mav.addObject("dto",dto);
    	mav.addObject("phoDtos",phoDto);

        return mav;
    }
    
    // 글 수정
    @Transactional(isolation = Isolation.READ_COMMITTED)
    @RequestMapping(value = "/freeUpdate")
    public ModelAndView freeUpdate(@RequestParam HashMap<String, String> params,
    		MultipartFile[] file) {
		logger.info("글 수정 요청");
		
		String boardNum = params.get("boardNum");
		
		ModelAndView mav = new ModelAndView();
    	
    	// 글 수정
    	service.freeUpdate(params);
    	
    	// 사진 업데이트
    	service.freePhoto(file, boardNum);
    	
    	mav.setViewName("redirect:./freeDetail/" + boardNum);
     	
        return mav;  	
    }
    
    // newfilename 으로 파일 삭제하기
    @RequestMapping(value = "/freePhotoDel")
    @ResponseBody
    public void photoDel(@RequestParam HashMap<String, Object> map) {
    	logger.info("글 사진 삭제 요청");
    	service.photoDel(map);
    }
    
    // 신고
    @RequestMapping(value = "/freeReport")
    @ResponseBody
    public void reviewReportForm(@RequestParam HashMap<String, String> map, HttpSession session) {
    	String loginId = (String)session.getAttribute("loginId");
    	logger.info("글 신고 요청");
    	logger.info("boardNum, 사유, loginId : " + map.get("boardNum") + "/" + map.get("reason") + "/" + loginId);
    	service.freeReport(map,loginId);
    }
    
    
    
    
}
