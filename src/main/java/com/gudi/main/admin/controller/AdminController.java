package com.gudi.main.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gudi.main.admin.service.AdminService;
import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.dtoAll.CommentDTO;
import com.gudi.main.dtoAll.CommentReportDTO;
import com.gudi.main.dtoAll.MemberDTO;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired AdminService adminService;
    
    
    @RequestMapping(value = "/authority")
    public String admin(Model model) {
        logger.info("관리자 메뉴");
        return "admin/authority/adminSearch";
    }
    
    @ResponseBody
    @RequestMapping(value = "/adminSearch/{page}", method = RequestMethod.GET)
    public HashMap<String, Object> adminSearch(@PathVariable int page) {
    	logger.info("관리자 조회");
        return adminService.adminSearch(page);
    }
    
    @RequestMapping(value = "/adminInsert")
    public String adminInsert(){
    	logger.info("관리자 임명 jsp로");
        return "admin/authority/adminInsert";
    }
    
    @ResponseBody
    @RequestMapping(value = "/adminInsertAjax/{page}",method = RequestMethod.GET)
    public HashMap<String, Object> adminInsertAjax(@PathVariable int page){
    	logger.info("관리자 임명");
        return adminService.adminInsertList(page);
    }
    
    @RequestMapping(value = "/adminInsertAuthority",method = RequestMethod.GET)
    public String adminInsertAuthority(@RequestParam("id") String id){
    	logger.info("관리자 임명 버튼 클릭");
    	logger.info("임명할 id: " +id);
    	adminService.adminInsert(id);
        return "admin/authority/adminInsert";
    }
    
    @ResponseBody
    @RequestMapping(value = "/insertSearch/{page}/{insertSearch}/{selectType}",method = RequestMethod.GET)
    public HashMap<String, Object> insertSearch(@PathVariable int page, @PathVariable String insertSearch, @PathVariable String selectType){
    	logger.info("관리자 임명 검색");
    	logger.info("셀렉터: "+selectType+", 검색내용: "+insertSearch);
        return adminService.insertSearch(selectType,insertSearch,page);
    }
    
    @RequestMapping(value = "/adminDeleteAuthority",method = RequestMethod.GET)
    public String adminDeleteAuthority(@RequestParam("id") String id){
    	logger.info("관리자 임명 버튼 클릭");
    	logger.info("임명할 id: " +id);
    	int success = adminService.adminDelete(id);
    	logger.info("성공여부: "+success);
        return "admin/authority/adminSearch";
    }
    //adminDeleteAuthority 권한해제
    
    @RequestMapping(value = "/memberInfo")
    public String memberInfo() {
    	logger.info("회원정보 조회");
        return "admin/list/memberInfo";
    }
    
    @ResponseBody
    @RequestMapping(value = "/memberInfoSearch/{page}/{memberInfoSearch}/{selectType}",method = RequestMethod.GET)
    public HashMap<String, Object> memberInfoSearch(@PathVariable int page, @PathVariable String memberInfoSearch, @PathVariable String selectType){
    	logger.info("회원정보 검색");
    	logger.info("셀렉터: "+selectType+", 검색내용: "+memberInfoSearch);
        return adminService.memberInfoSearch(selectType,memberInfoSearch,page);
    }
    
    @ResponseBody
    @RequestMapping(value = "/memberInfoAjax/{page}",method = RequestMethod.GET)
    public HashMap<String, Object> memberInfoAjax(@PathVariable int page) {
    	logger.info("회원정보 조회Ajax");
        return adminService.memberInfo(page);
    }
    @RequestMapping(value = "/memberInfoBlackDel")
    public String memberInfoBlackDel(@RequestParam("id") String id) {
    	logger.info("회원 블랙리스트 제거 조회");
    	logger.info("id: "+id+" 회원 블랙리스트 제거");
    	adminService.memberInfoBlackDel(id);
        return "admin/list/memberInfo";
    }
    
    @RequestMapping(value = "/memberInfoBlackList")
    public String memberInfoBlackList(@RequestParam("id") String id,@RequestParam("nickName") String nickName, Model model) {
    	logger.info("id: "+id+" 회원 블랙리스트 추가 페이지");
    	model.addAttribute("id",id);
    	model.addAttribute("nickName",nickName);
        return "admin/list/memberInfoBlackList";
    }
    
    @RequestMapping(value = "/memberInfoBlackInsert")
    public String memberInfoBlackInsert(@RequestParam("id") String id,@RequestParam("reason") String reason) {
    	logger.info("id: "+id+" 회원 블랙리스트 추가");
    	logger.info("사유: " +reason);
    	adminService.memberInfoBlackInsert(id, reason);
        return "admin/list/memberInfo";
    }
    
    
    @RequestMapping(value = "/memberReserve")
    public String memberReserve() {
    	logger.info("예약자 조회 jsp로");
        return "admin/list/memberReserve";
    }
    @ResponseBody
    @RequestMapping(value = "/memberReserveAjax/{page}",method = RequestMethod.GET)
    public HashMap<String, Object> memberReserveAjax(@PathVariable int page) {
    	logger.info("예약자 조회");
        return adminService.memberReserve(page);
    }
    @RequestMapping(value = "/boardList")
    public String boardList(Model model) {
        return "admin/list/boardList";
    }
    @ResponseBody
    @RequestMapping(value = "/boardListAjax/{page}",method = RequestMethod.GET)
    public HashMap<String, Object> boardList(@PathVariable int page) {
    	logger.info("게시글 조회 Ajax");
        return adminService.boardList(page);
    }
    
    @ResponseBody
    @RequestMapping(value = "/boardListSearch/{page}/{boardListSearch}/{selectType}",method = RequestMethod.GET)
    public HashMap<String, Object> boardListSearch(@PathVariable int page,@PathVariable("boardListSearch") String boardListSearch, @PathVariable("selectType") String selectType){
    	logger.info("게시글 검색");
    	logger.info("셀렉터: "+selectType+", 검색내용: "+boardListSearch);
        return adminService.boardListSearch(page,selectType,boardListSearch);
    }
    @RequestMapping(value = "/boardListDetailInfo",method = RequestMethod.GET)
    public String boardListDetailInfo(@RequestParam("boardNum") String boardNum,@RequestParam("division") String division,Model model){
    	logger.info("게시글 상세");
    	logger.info("게시글 번호: "+boardNum+"게시판 구분: "+division);
    	BoardDTO detail =adminService.boardListDetailInfo(boardNum,division);
    	model.addAttribute("detail", detail);
    	logger.info(detail.getId());
        return "admin/list/boardListDetail";
    }
    
    @RequestMapping(value = "/boardListBlack",method = RequestMethod.GET)
    public String boardListBlack(@RequestParam("boardNum") String boardNum,@RequestParam("division") String division){
    	logger.info("게시글 블랙리스트 추가");;
    	logger.info("게시글 번호: "+boardNum+"게시판 구분: "+division);
    	adminService.boardListBlack(boardNum,division);
        return "admin/list/boardList";
    }
    
    @RequestMapping(value = "/boardListUnBlack",method = RequestMethod.GET)
    public String boardListUnBlack(@RequestParam("boardNum") String boardNum,@RequestParam("division") String division){
    	logger.info("게시글 블랙리스트 해제");
    	logger.info("게시글 번호: "+boardNum+"게시판 구분: "+division);
    	adminService.boardListUnBlack(boardNum,division);
        return "admin/list/boardList";
    }
    
    @RequestMapping(value = "/comment")
    public String comment(Model model) {
        return "admin/comment/comment";
    }
    @RequestMapping(value = "/cmDetail")
    public String cmDetail(@RequestParam("cmNum") String cmNum,Model model) {
    	logger.info("댓글 상세보기");
    	logger.info(cmNum+"번 상세보기");
    	CommentDTO detail = adminService.cmDetail(cmNum);
    	model.addAttribute("detail", detail);
        return "admin/comment/cmDetail";
    }
    
    @RequestMapping(value = "/reportCmDetail")
    public String reportCmDetail(@RequestParam("cmReportNum") String cmReportNum,Model model) {
    	logger.info("신고 댓글 상세보기");
    	logger.info(cmReportNum+"번 상세보기");
    	CommentReportDTO detail = adminService.reportCmDetail(cmReportNum);
    	model.addAttribute("detail", detail);
        return "admin/comment/reportCmDetail";
    }
    
    @ResponseBody
    @RequestMapping(value = "/commentListAjax/{page}")
    public HashMap<String, Object> commentList(@PathVariable int page) {
    	logger.info("댓글 조회 Ajax");
        return adminService.commentList(page);
    }
    
    @ResponseBody
    @RequestMapping(value = "/commentListSearch/{page}/{commentListSearch}/{selectType}",method = RequestMethod.GET)
    public HashMap<String, Object> commentListSearch(@PathVariable int page, @PathVariable String commentListSearch, @PathVariable String selectType){
    	logger.info("일반댓글 검색");
    	logger.info("셀렉터: "+selectType+", 검색내용: "+commentListSearch);
        return adminService.commentListSearch(selectType,commentListSearch,page);
    }
    
    @RequestMapping(value = "/reportComment")
    public String reportComment(Model model) {
        return "admin/comment/reportComment";
    }
    
    @ResponseBody
    @RequestMapping(value = "/reportCommentAjax/{page}",method = RequestMethod.GET)
    public HashMap<String, Object> reportCommentList(@PathVariable int page) {
        return adminService.reportCommentList(page);
    }
    @RequestMapping(value = "/reportCommentProcess")
    public String reportCommentProcess(@RequestParam int cmReportNum) {
    	logger.info("신고댓글 처리: "+cmReportNum);
    	adminService.reportCommentProcess(cmReportNum);
        return "admin/comment/reportComment";
    }
    
    
    


}
