package com.gudi.main.campingTalk.freeBoard.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.dtoAll.PhotoDTO;

@Mapper
public interface FreeMapper {
	
	// 게시판 불러오기 
	// @Select("SELECT * FROM freeBoard WHERE delcheck = 'n' ORDER BY boardnum DESC")
	@Select("SELECT rnum, BOARDNUM, ID, CONTENT, TITLE, DATES, BOARDHIT\r\n" + 
			"FROM\r\n" + 
			"(SELECT row_number() OVER(ORDER BY boardnum DESC) rnum,BOARDNUM,ID,CONTENT,TITLE,DATES,BOARDHIT,DELCHECK,DIVISION FROM freeboard WHERE delcheck = 'N') OFFSET #{param1} ROWS FETCH FIRST 10 ROWS ONLY")
	ArrayList<BoardDTO> freeList(int page);
	
	// 전체 페이지 수 삭제처리 한거 제외
	@Select("SELECT COUNT(boardnum) FROM freeboard where delcheck='N'")
	int total();
	
	// 글쓰기
	@Insert("INSERT INTO freeboard(boardnum, id, title, content) VALUES (freeboard_seq.NEXTVAL, #{loginId}, #{title}, #{content})")
	@SelectKey(statement = {"SELECT freeboard_seq.CURRVAL FROM DUAL"}, keyProperty = "boardnum",resultType = int.class, before = false)
	int freeWrite(HashMap<String, String> params);
	
	// 사진 업로드
	@Insert("INSERT INTO photo(photonum, id, division, newfilename, orifilename, divisionnum) VALUES (photo_seq.NEXTVAL, 'test', 'free', #{param1}, #{param2}, #{param3})")
	void freePhoto(String neww, String ori, String boardNum);
	
	// 사진 불러오기
	@Select("SELECT newfilename, orifilename FROM photo WHERE divisionnum = #{boardNum}")
	ArrayList<PhotoDTO> callPhoto(int boardNum);
	
	// 상세보기
	@Select("SELECT * FROM freeboard WHERE boardNum = #{param1}")
	BoardDTO freeDetail(int boardNum);
	
	// 조회수 
	@Update("UPDATE freeboard SET boardhit = boardhit+1 WHERE boardNum = #{param1}")
	void freeHit(int boardNum);
	
	// 글 삭제
	@Update("UPDATE freeboard SET delcheck = 'Y' WHERE boardnum = #{boardNum}")
	int freeDel(int boardNum);
	
	// 글 수정
	@Update("UPDATE freeboard SET title = #{param1}, content = #{param2} WHERE boardnum = #{param3}")
	int freeUpdate(String title, String content, int boardNum);
	
	// 사진 수정
	@Update("UPDATE photo SET newfilename = #{param1}, orifilename = #{param2} WHERE divisionnum = #{param3}")
	void freePhotoUpdate(String neww, String ori, int boardNum);
	
	// 사진 삭제
	@Delete("DELETE photo WHERE newfilename= #{param1} AND divisionnum = #{param2}")
	void photoDel(String newFileName, int boardNum);
	
	// 글 신고
	@Insert("INSERT INTO freereport(freeReportNum, boardNum, reporter, reason) VALUES(freeReport_seq.NEXTVAL, #{boardNum}, #{loginId}, #{reason})")
	void freeReport(HashMap<String, String> map);

	

	
}
