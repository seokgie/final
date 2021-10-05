package com.gudi.main.campingServiceCenter.questionBoard.controller;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.main.campingServiceCenter.questionBoard.service.QuestionService;

@Controller
@RequestMapping(value = "/serviceCenter")
public class QuestionController {
    Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    QuestionService service;
    
    @RequestMapping(value = "/questionBoard/{page}")
    public ModelAndView questionBoard(@PathVariable int page) {
        logger.info("문의하기입장");
        return service.list(page);
    }
    
   /* @ResponseBody
    @RequestMapping(value = "/questionBoardList/{pagePerNum}/{page}", method = RequestMethod.GET)
    public HashMap<String, Object> list(@PathVariable int pagePerNum, @PathVariable int page) {
        logger.info("공지사항 리스트");
        //@PathVariable 경로에 있는 녀석을 변수로 담는다.
        logger.info("pagePerNum : {} / page : {}", pagePerNum, page);
        HashMap<String, Object> map = service.list(page, pagePerNum);
        return map;
    }*/

    @RequestMapping(value = "/questionDetail/{boardNum}")
    public ModelAndView questionDetail(@PathVariable int boardNum,HttpSession session) {
    	String loginId = (String)session.getAttribute("loginId");
    	logger.info("문의사항 디테일 실행");
        return service.detail(boardNum,loginId);
        
    }
    
    @RequestMapping(value = "/questionWriteForm")
	public String questionWriteForm() {
		System.out.println("폼이동");
    	return "serviceCenter/questionBoard/questionWriteForm";
	}
    
    @Transactional
    @RequestMapping(value = "/questionWrite")
    public ModelAndView reviewWrite(@RequestParam HashMap<String, String> params,
    		MultipartFile[] file,HttpSession session) {
    	logger.info("공지사항 작성"+params);
    	
    	
    	ModelAndView mav = new ModelAndView();
    	
    	String loginId=(String) session.getAttribute("loginId");
    	
    	
    	
    	//리뷰글 등록
    	service.questionWrite(params,loginId);
    	String boardNum = String.valueOf(params.get("boardnum"));
    	System.out.println("suc은 시퀀스 넘버인가?:: "+ boardNum);
    	
    	//파일업로드
     /*	service.questionPhoto(file, boardNum); */
    	
    	mav.setViewName("redirect:./questionDetail/"+boardNum);
     	
        return mav;
    }

    //삭제
    @RequestMapping(value = "/questionDel/{boardNum}")
    public String questionDel(@PathVariable int boardNum, Model model) {
    	logger.info("삭제한 글의 번호:: "+boardNum);
    	
    	int suc = service.questionDel(boardNum);
    	if (suc>0) {
    		String delmsg = " 삭제되었습니다.";
			model.addAttribute("delmsg",delmsg);
		}
        return "redirect:../questionBoard";
    }
    
    
    @RequestMapping(value = "/questionUpdateForm/{boardNum}")
    public ModelAndView questionUpdateForm(@PathVariable int boardNum) {
    	logger.info("수정할 글의 글번호: "+boardNum);
        return service.update(boardNum);
    }
    
    @Transactional(isolation = Isolation.READ_COMMITTED)
    @RequestMapping(value = "/questionUpdate")
    public ModelAndView reviewUpdate(@RequestParam HashMap<String, String> params,
    		MultipartFile[] file) {
		logger.info("수정 등록 요청...");
		String boardNum = params.get("boardNum");
		ModelAndView mav = new ModelAndView();
    	//리뷰글 수정
    	service.questionUpdate(params);
    	//사진 업뎃
    	/*service.questionPhoto(file, boardNum);*/
    	mav.setViewName("redirect:./questionDetail/"+boardNum);
        return mav;  	
    }
    
    /*
    @RequestMapping(value = "/photoDel")
    @ResponseBody
    public void photoDel(@RequestParam HashMap<String, Object> map) {
    	logger.info("사진 삭제 요청...");
    	service.photoDel(map);
    }
    */
    
}

