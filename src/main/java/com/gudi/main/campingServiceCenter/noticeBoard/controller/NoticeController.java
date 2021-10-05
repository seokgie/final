package com.gudi.main.campingServiceCenter.noticeBoard.controller;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.main.campingServiceCenter.noticeBoard.service.NoticeService;
import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.dtoAll.PhotoDTO;

@Controller
@RequestMapping(value = "/serviceCenter")
public class NoticeController {
    Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    NoticeService service;

    @RequestMapping(value = "/noticeBoard")
    public ModelAndView NoticeBoard() {
    	int page = 1;
        logger.info("공지사항입장");
        return service.list(page);
    }
    
    @RequestMapping(value = "/noticeBoard/{page}")
    public ModelAndView NoticeBoard(@PathVariable int page) {
    	System.out.println(page+" 페이지 공지사항");
        	return service.list(page);
    }

	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/noticeBoardList/{pagePerNum}/{page}", method =
	 * RequestMethod.GET) public HashMap<String, Object> list(@PathVariable int
	 * pagePerNum, @PathVariable int page) { logger.info("공지사항 리스트");
	 * //@PathVariable 경로에 있는 녀석을 변수로 담는다.
	 * logger.info("pagePerNum : {} / page : {}", pagePerNum, page); HashMap<String,
	 * Object> map = service.list(page, pagePerNum); return map; }
	 */

    @RequestMapping(value = "/noticeDetail/{boardNum}")
    public ModelAndView noticeDetail(@PathVariable int boardNum,HttpSession session) {
    	String loginId = (String)session.getAttribute("loginId");
    	logger.info("공지사항 디테일 실행");
        return service.detail(boardNum,loginId);
        
    }
    
    @RequestMapping(value = "/noticeWriteForm")
	public String noticeWriteForm() {
    	
    	
		return "serviceCenter/noticeBoard/noticeWriteForm";
	}
    
    @Transactional
    @RequestMapping(value = "/noticeWrite")
    public ModelAndView reviewWrite(@RequestParam HashMap<String, String> params,
    		MultipartFile[] file, HttpSession session) {
    	logger.info("공지사항 작성"+params);
    	String loginId = (String)session.getAttribute("loginId");
    	ModelAndView mav = new ModelAndView();
    	
    	params.put("id", loginId);
    	//리뷰글 등록
    	service.noticeWrite(params);
    	String boardNum = String.valueOf(params.get("boardnum"));
    	System.out.println("suc은 시퀀스 넘버인가?:: "+ boardNum);
    	
    	//파일업로드
    	service.noticePhoto(file, boardNum,loginId);
    	
    	mav.setViewName("redirect:./noticeDetail/"+boardNum);
     	
        return mav;
    }

    //삭제
    @RequestMapping(value = "/noticeDel/{boardNum}")
    public String noticeDel(@PathVariable int boardNum, Model model) {
    	logger.info("삭제한 글의 번호:: "+boardNum);
    	
    	int suc = service.noticeDel(boardNum);
    	if (suc>0) {
    		String delmsg = " 삭제되었습니다.";
			model.addAttribute("delmsg",delmsg);
		}
        return "redirect:../noticeBoard";
    }
    
    
    @RequestMapping(value = "/noticeUpdateForm/{boardNum}")
    public ModelAndView noticeUpdateForm(@PathVariable int boardNum) {
    	logger.info("수정할 글의 글번호: "+boardNum);
        return service.update(boardNum);
    }
    
    @Transactional(isolation = Isolation.READ_COMMITTED)
    @RequestMapping(value = "/noticeUpdate")
    public ModelAndView reviewUpdate(@RequestParam HashMap<String, String> params,
    		MultipartFile[] file,HttpSession session) {
		logger.info("수정 등록 요청...");
		String loginId = (String)session.getAttribute("loginId");
		String boardNum = params.get("boardNum");
		ModelAndView mav = new ModelAndView();
    	//리뷰글 수정
    	service.noticeUpdate(params);
    	//사진 업뎃
    	service.noticePhoto(file, boardNum,loginId);
    	mav.setViewName("redirect:./noticeDetail/"+boardNum);
        return mav;  	
    }
    
    @RequestMapping(value = "/photoDel")
    @ResponseBody
    public void photoDel(@RequestParam HashMap<String, Object> map) {
    	logger.info("사진 삭제 요청...");
    	service.photoDel(map);
    }
    
    
}
