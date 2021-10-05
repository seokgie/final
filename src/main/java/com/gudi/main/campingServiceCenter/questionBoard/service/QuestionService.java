package com.gudi.main.campingServiceCenter.questionBoard.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.main.campingServiceCenter.questionBoard.dao.QuestionMapper;
import com.gudi.main.cm.CmService;
import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.good.GoodMapperCommon;
import com.gudi.main.util.HansolUtil;

@Service
public class QuestionService {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired
	QuestionMapper dao;
	
	@Autowired
	CmService service;
	
	@Autowired GoodMapperCommon goodMapper;

	

	@Transactional
	public ModelAndView detail(int boardNum,String loginId) {
		ModelAndView mav = new ModelAndView();
		HashMap<String,Object> map = service.cmList(Integer.toString(boardNum), "question", 1);
		dao.up(boardNum);
		
		/*
		ArrayList<PhotoDTO> phoDto = dao.callPhoto(boardNum);
		*/
		BoardDTO dto = dao.detail(boardNum);
		mav.addObject("dto", dto);
		
		/*
		ArrayList<PhotoDTO> file = dao.file(boardNum);
		mav.addObject("phoDtos", phoDto);
		*/
		map.put("goodCount",goodMapper.goodCount(Integer.toString(boardNum), "question"));
    	String check = null;
    	if(loginId != null) {
    		check = goodMapper.goodCheck(Integer.toString(boardNum), "question", loginId);
    	}
    	if (check == null) {
            map.put("goodCheck", false);
        } else {
            map.put("goodCheck", true);
        }
    	
    	mav.addObject("map", map);
    	
		mav.setViewName("/serviceCenter/questionBoard/questionDetail");
		return mav;
	}
	

	public int questionWrite(HashMap<String, String> params, String loginId) {
		//logger.info(params.get("title") + " / " + params.get("content"));
		params.put("loginId",loginId);
		return dao.questionWrite(params);

	}

 /*
	public void questionPhoto(MultipartFile[] file, String boardNum) {
		HashMap<String, String> map;
		String neww = "";
		String ori = "";

		for (int i = 0; i < file.length; i++) {
			map = UploadUtil.fileUpload(file[i]);
			neww = map.get("newFileName");
			ori = map.get("oriFileName");

			dao.questionPhoto(neww, ori, boardNum);

		}

	}
	*/

	public int questionDel(int boardNum) {
		return dao.questionDel(boardNum);
	}

	
	public ModelAndView update(int boardNum) {
		//수정폼 요청하면서 기존의 글내용을 전달
    	ModelAndView mav = new ModelAndView();
    	
    	/*
    	//사진 불러옴
    	ArrayList<PhotoDTO> phoDto = dao.callPhoto(boardNum);
    	*/ 
    	
    	//글 불러옴
    	BoardDTO dto = dao.detail(boardNum);
    	mav.setViewName("/serviceCenter/questionBoard/questionUpdateForm");
    	mav.addObject("dto",dto);
    	/*
    	mav.addObject("phoDtos",phoDto);
    	*/
		return mav;
	}

	public int questionUpdate(HashMap<String, String> params) {
logger.info(params.get("title")+" / "+params.get("content"));
		
		String title = params.get("title");
		String content = params.get("content");
		int boardNum = Integer.parseInt(params.get("boardNum"));
		return dao.questionUpdate(title,content,boardNum);
		
	}



	public ModelAndView list(int page) {
		ModelAndView mav = new ModelAndView();
		int total = dao.allCount();
		HashMap<String, Object> map = HansolUtil.pagination(page, 10, total);
		if (page == 1) {
			page = 0;
		} else {
			page = (page - 1) * 10;
		}
		ArrayList<BoardDTO> list = dao.lists(page);
		map.put("list", list);
		mav.addObject("map", map);
		mav.setViewName("/serviceCenter/questionBoard/questionBoardList");
		return mav;
	}
	

	/*
	public void photoDel(HashMap<String, Object> map) {
		int boardNum = Integer.parseInt((String)map.get("boardNum"));
		String newFileName = (String) map.get("newFileName");
		
		dao.photoDel(newFileName, boardNum);		
	}
	*/
}
