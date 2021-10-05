package com.gudi.main.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gudi.main.admin.dao.AdminMapper;
import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.dtoAll.CommentDTO;
import com.gudi.main.dtoAll.CommentReportDTO;
import com.gudi.main.dtoAll.MemberDTO;
import com.gudi.main.dtoAll.ReserveDTO;
import com.gudi.main.util.HansolUtil;

@Service
public class AdminService {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired AdminMapper dao;
	ArrayList<MemberDTO> list = null;
	HashMap<String , Object> map = null;
	ArrayList<ReserveDTO> list2 = null;
	ArrayList<BoardDTO> list3 = null;
	ArrayList<CommentDTO> list4 = null;
	
	
	public HashMap<String, Object> adminSearch(int page) {
		logger.info("관리자 조회 서비스");
		 int start = 0;
	        if (page != 1) {
	            start = (page - 1) * 15;
	        }
	    int total = dao.page();
	    HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);
		list = dao.adminList(start);
		map.put("list", list);
		return map;
	}

	public HashMap<String, Object> adminInsertList(int page) {
		logger.info("관리자 임명 리스트 서비스");
		 int start = 0;
	        if (page != 1) {
	            start = (page - 1) * 15;
	     }
	    int total = dao.adminN();
	    HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);
		list = dao.adminInsertList(start);
		map.put("list",list);
		return map;
	}

	public HashMap<String, Object> memberReserve(int page) {
		logger.info("예약자 조회 서비스");
		int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        int total = dao.memberReservepage();
        HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);
		list2 = dao.memberReserve(start);
		map.put("list",list2);
		logger.info("예약자 수: " + list2.size());
		return map;
	}

	public HashMap<String, Object> memberInfo(int page) {
		logger.info("회원 조회 서비스");
		int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        int total = dao.memberPage();
        HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);
		list = dao.memberInfo(start);
		map.put("list",list);
		return map;
	}

	public String adminInsert(String id) {
		logger.info("관리자 임명 서비스");
		dao.adminInsert(id);
		return null;
	}

	public HashMap<String, Object> insertSearch(String selectType, String insertSearch, int page) {
		logger.info("관리자 임명 검색 서비스");
		
		int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        
        int total=0;
        HashMap<String, Object> map = null;
		switch(selectType){
		case "nickName":
			total = dao.insertSearchByNicknameWithAdminPage(insertSearch);
			map = HansolUtil.pagination(page, 15, total);
			list= dao.insertSearchByNicknameWithAdmin(insertSearch,start);
			break;
		case "email":
			total = dao.insertSearchByEmailnameWithAdminPage(insertSearch);
			map = HansolUtil.pagination(page, 15, total);
			list= dao.insertSearchByEmailWithAdmin(insertSearch,start);
			break;
			
		case "id":
			total = dao.insertSearchByIdnameWithAdminPage(insertSearch);
			map = HansolUtil.pagination(page, 15, total);
			list= dao.insertSearchByIdWithAdmin(insertSearch,start);
			break;
		} 
		
		
		// 이름 list= dao.insertSearchByNickname(insertSearch);
		//아이디
		//이메일
		map.put("list",list);
		logger.info("돌아온값: " + list.size());
		return map;
	}

	public int adminDelete(String id) {
		int success = dao.adminDelete(id);
		return success;
	}

	public HashMap<String, Object> boardList(int page) {
		logger.info("게시글 조회 서비스");
		int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        int total = dao.boardListPage();
        logger.info("토탈: "+total);
        HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);
		list3 = dao.boardList(start);
		map.put("list",list3);
		return map;
	}

	public HashMap<String, Object> commentList(int page) {
		logger.info("댓글 조회 서비스");
		int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        int total = dao.commentListPage();
        HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);
		list4 = dao.commentList(start);
		logger.info("댓글 갯수: "+list4.size());
		map.put("list",list4);
		return map;
	}

	public HashMap<String, Object> reportCommentList(int page) {
		logger.info("신고댓글 조회 서비스");
		ArrayList<CommentReportDTO> list5 = new ArrayList<CommentReportDTO>();
		int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        int total = dao.reportCommentListPage();
        HashMap<String, Object> map = HansolUtil.pagination(page, 15, total);
		list5 = dao.reportCommentList(start);
		map.put("list",list5);
		return map;
	}

	public HashMap<String, Object> memberInfoSearch(String selectType, String memberInfoSearch, int page) {
		logger.info("회원정보 검색 서비스");
		int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        
        int total=0;
        HashMap<String, Object> map = null;
		switch(selectType){
		case "nickName":
			total = dao.memberInfoSearchByNickNamePage(memberInfoSearch);
			map = HansolUtil.pagination(page, 15, total);
			list= dao.memberInfoSearchByNickName(memberInfoSearch,start);
			break;
		case "email":
			total = dao.memberInfoSearchByEmailPage(memberInfoSearch);
			map = HansolUtil.pagination(page, 15, total);
			list= dao.memberInfoSearchByEmail(memberInfoSearch, start);
			break;
		case "id":
			total = dao.memberInfoSearchByIdPage(memberInfoSearch);
			map = HansolUtil.pagination(page, 15, total);
			list= dao.memberInfoSearchById(memberInfoSearch,start);
			break;
		}
		map.put("list",list);
		logger.info("돌아온값: " + list.size());
		return map;
	}

	public HashMap<String, Object> boardListSearch(int page, String selectType, String boardListSearch) {
		logger.info("게시글 리스트 검색 서비스");
		int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        
        int total=0;
        HashMap<String, Object> map = null;
		switch(selectType){
		case "title":
			total = dao.commentListSearchByContentPage(boardListSearch);
			map = HansolUtil.pagination(page, 15, total);
			list3= dao.boardListSearchBytitle(boardListSearch,start);
			break;
	
		case "id":
			total = dao.commentListSearchByContentPage(boardListSearch);
			map = HansolUtil.pagination(page, 15, total);
			list3= dao.boardListSearchById(boardListSearch,start);
			break;
		}
		map.put("list",list3);
		logger.info("검색한 게시글 수: " + list3.size());
		return map;
	}

	public HashMap<String, Object> commentListSearch(String selectType, String commentListSearch, int page) {
		logger.info("댓글 리스트 검색 서비스");
		int start = 0;
        if (page != 1) {
            start = (page - 1) * 15;
        }
        
        int total=0;
        HashMap<String, Object> map = null;
		switch(selectType){
		case "content":
			total = dao.commentListSearchByContentPage(commentListSearch);
			map = HansolUtil.pagination(page, 15, total);
			list4= dao.commentListSearchByContent(commentListSearch,start);
			break;

		case "id":
			total = dao.commentListSearchByIdPage(commentListSearch);
			map = HansolUtil.pagination(page, 15, total);
			list4= dao.commentListSearchById(commentListSearch,start);
			break;
		}
		map.put("list",list4);
		logger.info("돌아온값: " + list4.size());
		return map;
	}

	public String memberInfoBlackDel(String id) {
		logger.info("멤버 블랙리스트 제거 서비스");
		logger.info("id: "+id+ "블랙리스트 제거 서비스");
	
		
		int success=dao.memberInfoBlackDel2(id);
		if(success!=0) {
			logger.info("해제 성공");
		}
		return null;
	}

	public String memberInfoBlackInsert(String id, String reason) {
		logger.info("블랙리스트 추가 서비스");
		logger.info("id: "+id+ "블랙리스트 추가 서비스");
		//있는지 없는지
		int success = dao.memberInfoBlackInsert(id);
		if(success!=0) {
			logger.info("업데이트");
			//있다면 업데이트
			dao.memberInfoBlackInsert1(id, reason);
		}
		
		
		if(success==0) {
			//없으면 추가
			dao.memberInfoBlackInsert2(id, reason);
			logger.info("추가");
		}
		return null;
	}

	public BoardDTO boardListDetailInfo(String boardNum, String division) {
		logger.info("게시물 상세보기 서비스");
		BoardDTO detail = new BoardDTO();
		map = new HashMap<String , Object>();
		detail=dao.boardListDetailInfo(boardNum,division);
		return detail;
	}

	public void boardListBlack(String boardNum, String division) {
		logger.info("게시글 블랙리스트 추가 서비스");
		int success=0;
		switch(division) {
		case "1":
			success = dao.boardListBlackDivision1(boardNum);
			break;
		case "2":
			success = dao.boardListBlackDivision2(boardNum);
			break;
		case "3":
			success = dao.boardListBlackDivision3(boardNum);
			break;
		case "4":
			success = dao.boardListBlackDivision4(boardNum);
			break;
			
		}
		if(success!=0) {
		logger.info("추가성공");
		}
		
	}

	public void boardListUnBlack(String boardNum, String division) {
		logger.info("게시글 블랙리스트 해제 서비스");
		int success=0;
		switch(division) {
		case "1":
			success = dao.boardListUnBlackDivision1(boardNum);
			break;
		case "2":
			success = dao.boardListUnBlackDivision2(boardNum);
			break;
		case "3":
			success = dao.boardListUnBlackDivision3(boardNum);
			break;
		case "4":
			success = dao.boardListUnBlackDivision4(boardNum);
			break;
			
		}
		if(success!=0) {
			logger.info("해제 성공");
			}
		
	}

	public CommentDTO cmDetail(String cmNum) {
		logger.info("댓글 상세보기 서비스");
		CommentDTO detail = new CommentDTO();
		detail = dao.cmDetail(cmNum);
		return detail;
	}

	public CommentReportDTO reportCmDetail(String cmReportNum) {
		logger.info("신고 댓글 상세보기 서비스");
		CommentReportDTO detail = new CommentReportDTO();
		detail=dao.reportCmDetail(cmReportNum);
		return detail;
	}

	public void reportCommentProcess(int cmReportNum) {
		logger.info("신고댓글 처리 서비스");
		int success = dao.reportCommentProcess(cmReportNum);
		
	}

	
	
	
}
