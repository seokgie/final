package com.gudi.main.admin.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.dtoAll.CommentDTO;
import com.gudi.main.dtoAll.CommentReportDTO;
import com.gudi.main.dtoAll.MemberDTO;
import com.gudi.main.dtoAll.ReserveDTO;

@Mapper
public interface
AdminMapper {
	
	@Select("Select * from member where admin = 'Y' OFFSET #{param1} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<MemberDTO> adminList(int start);
	
	@Select("Select * from member where admin='N' OFFSET #{param1} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<MemberDTO> adminInsertList(int start);
	
	@Select("Select r.id, r.reserveName,r.manCount, r.contentId, r.reserveDate from reserve r OFFSET 0 ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<ReserveDTO> memberReserve(int start);

	@Select("select m.id, m.nickName, b.reason, b.status from member m left outer join black b on m.id = b.id where admin='N' OFFSET #{param1} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<MemberDTO> memberInfo(int start);
	
	@Select("Select *from member where nickName LIKE '%'||#{param1}||'%' OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<MemberDTO> memberInfoSearchByNickName(String memberInfoSearch, int start);
	
	@Select("Select *from member where email LIKE '%'||#{param1}||'%' OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<MemberDTO> memberInfoSearchByEmail(String memberInfoSearch, int start);

	@Select("Select *from member where id LIKE '%'||#{param1}||'%' OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<MemberDTO> memberInfoSearchById(String memberInfoSearch, int start);

	@Update("update member SET admin='Y' where id =#{id} ")
	void adminInsert(String id);
	
	@Select("Select *from member where nickName LIKE '%'||#{param1}||'%' AND admin = 'N' OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<MemberDTO> insertSearchByNicknameWithAdmin(String insertSearch, int start);
	
	@Select("Select *from member where email LIKE '%'||#{param1}||'%' AND admin = 'N' OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<MemberDTO> insertSearchByEmailWithAdmin(String insertSearch, int start);

	@Select("Select *from member where id LIKE '%'||#{param1}||'%' AND admin = 'N' OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<MemberDTO> insertSearchByIdWithAdmin(String insertSearch, int start);
	
	@Update("update member SET admin='0' where id =#{id} ")
	int adminDelete(String id);
	
	@Select("select division,boardNum,id,title, delcheck from noticeBoard UNION all"+
			" select division,boardNum,id, title, cast('delcheck' as nvarchar2(100)) from questionBoard UNION all" + 
			" select division,boardNum,id,title, delcheck from freeBoard UNION all" + 
			" select division,boardNum,id,title, cast('delcheck' as nvarchar2(100)) from reviewBoard OFFSET #{param1} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<BoardDTO> boardList(int start);

	@Select("Select * from cm OFFSET #{param1} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<CommentDTO> commentList(int start);
	
	@Select("select c.cmReportNum, c.cmNum, c.reporter,cm.id, c.status, cm.content from cmreport c left outer join cm on c.cmNum=cm.cmNum where status = 'N' OFFSET #{param1} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<CommentReportDTO> reportCommentList(int start);

	//게시글 조회 검색
	//게시글 조인
	@Select("select * from (select division,boardNum, id,title, delcheck from noticeBoard where title LIKE '%'||#{param1}||'%'"+ 
			" UNION all"+
			" select division,boardNum,id, title, cast('delcheck' as nvarchar2(100)) from questionBoard where title LIKE '%'||#{param1}||'%'"+ 
			" UNION all" + 
			" select division,boardNum,id,title, delcheck from freeBoard where title LIKE '%'||#{param1}||'%'"+ 
			" UNION all" + 
			" select division,boardNum,id,title, cast('delcheck' as nvarchar2(100)) from reviewBoard where title LIKE '%'||#{param1}||'%') OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<BoardDTO> boardListSearchBytitle(String boardListSearch, int start);

	@Select("select * from (select division,boardNum,id,title, delcheck from noticeBoard where id LIKE '%'||#{param1}||'%'"+ 
			" UNION all"+
			" select division,boardNum,id, title, cast('delcheck' as nvarchar2(100)) from questionBoard where id LIKE '%'||#{param1}||'%'"+ 
			" UNION all" + 
			" select division,boardNum,id,title, delcheck from freeBoard where id LIKE '%'||#{param1}||'%'"+ 
			" UNION all" + 
			" select division,boardNum,id,title, cast('delcheck' as nvarchar2(100)) from reviewBoard where id LIKE '%'||#{param1}||'%') OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<BoardDTO> boardListSearchById(String boardListSearch, int start);
	
	//일반 댓글조회 검색
	//댓글, 멤버 조인
	@Select("Select *from cm where content LIKE '%'||#{param1}||'%' OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<CommentDTO> commentListSearchByContent(String commentListSearch, int start);
	
	
	@Select("Select *from cm where id LIKE '%'||#{param1}||'%' OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
	ArrayList<CommentDTO> commentListSearchById(String commentListSearch, int start);
	
	
	//@Update("update black SET status='N' and reason='N' where id =#{id} ")
	//@Delete("delete black where id =#{id}")
	@Update("update black SET status='N', reason='N' where id =#{id} ")
	int memberInfoBlackDel2(String id);
	/*
	 * //@Update("update member SET DELCHECK='Y' where id =#{param1} ")
	 * 
	 * @Update("insert into black values(BLACK_SEQ.nextval,#{param1},#{param2},sysdate,'Y')"
	 * ) int memberInfoBlackInsert(String id, String reason);
	 */
	@Select("select count(id) from black where id = #{param1}")
	int memberInfoBlackInsert(String id);

	@Update("update black SET status='Y', reason= #{param2} where id =#{param1}")
	int memberInfoBlackInsert1(String id, String reason);

	@Update("insert into black values(BLACK_SEQ.nextval,#{param1},#{param2},sysdate,'Y')")
	int memberInfoBlackInsert2(String id, String reason);

	@Select("select division,boardNum,id,title,content, delcheck from noticeBoard where boardNum = #{param1} and division=#{param2}"+ 
			" UNION all"+
			" select division,boardNum,id, title,content, cast('delcheck' as nvarchar2(100)) from questionBoard where boardNum = #{param1} and division=#{param2}"+ 
			" UNION all" + 
			" select division,boardNum,id,title,content, delcheck from freeBoard where boardNum = #{param1} and division=#{param2}"+ 
			" UNION all" + 
			" select division,boardNum,id,title,content, cast('delcheck' as nvarchar2(100)) from reviewBoard where boardNum = #{param1} and division=#{param2}")
	BoardDTO boardListDetailInfo(String boardNum, String division);

	
	@Update("update noticeBoard SET DELCHECK='Y' where boardNum =#{boardNum}")
	int boardListBlackDivision1(String boardNum);

	@Update("update questionBoard SET DELCHECK='Y' where boardNum =#{boardNum}")
	int boardListBlackDivision2(String boardNum);

	@Update("update freeBoard SET DELCHECK='Y' where boardNum =#{boardNum}")
	int boardListBlackDivision3(String boardNum);

	@Update("update reviewBoard SET DELCHECK='Y' where boardNum =#{boardNum}")
	int boardListBlackDivision4(String boardNum);
	
	//해제
	@Update("update noticeBoard SET DELCHECK='N' where boardNum =#{boardNum}")
	int boardListUnBlackDivision1(String boardNum);

	@Update("update questionBoard SET DELCHECK='N' where boardNum =#{boardNum}")
	int boardListUnBlackDivision2(String boardNum);

	@Update("update freeBoard SET DELCHECK='N' where boardNum =#{boardNum}")
	int boardListUnBlackDivision3(String boardNum);

	@Update("update reviewBoard SET DELCHECK='N' where boardNum =#{boardNum}")
	int boardListUnBlackDivision4(String boardNum);

	@Select("select * from cm where cmNum=#{cmNum}")
	CommentDTO cmDetail(String cmNum);
	
	@Select("select c.cmReportNum, c.cmNum, c.reporter,cm.id, cm.content, c.reason, c.status from cmreport c left outer join cm on c.cmNum=cm.cmNum where c.cmReportNum=#{cmReportNum}")
	CommentReportDTO reportCmDetail(String cmReportNum);
	
	@Select("select COUNT(*) from member where admin='Y'")
	int page();
	
	@Select("select COUNT(*) from member where admin='N'")
	int adminN();
	
	@Select("select COUNT(*) from member where admin='N'")
	int memberPage();
	
	@Select("Select COUNT(*) from reserve ")
	int memberReservepage();
	
	@Select("select COUNT(*) from (" + 
			"    select division,boardNum,id,title, delcheck from noticeBoard UNION all" + 
			"	 select division,boardNum,id, title, cast('delcheck' as nvarchar2(100)) from questionBoard UNION all" + 
			"    select division,boardNum,id,title, delcheck from freeBoard UNION all" + 
			"	 select division,boardNum,id,title, cast('delcheck' as nvarchar2(100)) from reviewBoard)")
	int boardListPage();
	
	@Select("Select COUNT(*) from cm ")
	int commentListPage();
	
	@Select("Select COUNT(*) from cmReport ")
	int reportCommentListPage();
	
	@Select("Select COUNT(*) from member where nickName LIKE '%'||#{insertSearch}||'%' AND admin = 'N'")
	int insertSearchByNicknameWithAdminPage(String insertSearch);
	
	@Select("Select COUNT(*) from member where email LIKE '%'||#{insertSearch}||'%' AND admin = 'N'")
	int insertSearchByEmailnameWithAdminPage(String insertSearch);
	
	@Select("Select COUNT(*) from member where id LIKE '%'||#{insertSearch}||'%' AND admin = 'N'")
	int insertSearchByIdnameWithAdminPage(String insertSearch);

	
	@Select("Select COUNT(*) from member where nickName LIKE '%'||#{memberInfoSearch}||'%'")
	int memberInfoSearchByNickNamePage(String memberInfoSearch);
	
	@Select("Select COUNT(*) from member where email LIKE '%'||#{memberInfoSearch}||'%'")
	int memberInfoSearchByEmailPage(String memberInfoSearch);

	@Select("Select COUNT(*) from member where id LIKE '%'||#{memberInfoSearch}||'%'")
	int memberInfoSearchByIdPage(String memberInfoSearch);
	
	@Select("Select COUNT(*) from cm where content LIKE '%'||#{param1}||'%'")
	int commentListSearchByContentPage(String commentListSearch);

	@Select("Select COUNT(*) from cm where id LIKE '%'||#{param1}||'%'")
	int commentListSearchByIdPage(String commentListSearch);
	
	@Update("UPDATE cmReport SET status='Y' WHERE cmReportNum=#{cmReportNum}")
	int reportCommentProcess(int cmReportNum);

	
	

	
	

	
	
}
