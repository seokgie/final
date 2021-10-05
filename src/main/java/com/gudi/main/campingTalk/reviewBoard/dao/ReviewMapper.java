package com.gudi.main.campingTalk.reviewBoard.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.dtoAll.CommentDTO;
import com.gudi.main.dtoAll.PhotoDTO;

@Mapper
public interface ReviewMapper {

	@Insert("INSERT INTO photo(photonum, id, division, newfilename, orifilename, divisionnum) VALUES (photo_seq.NEXTVAL, 'test', 'review', #{param1}, #{param2}, #{param3})")
	void reviewPhoto(String neww, String ori, String boardNum);

	@Insert("INSERT INTO reviewboard(boardnum, id, title, content) VALUES (reviewboard_seq.NEXTVAL, #{loginId}, #{title}, #{content})")
	@SelectKey(statement = {
			"SELECT reviewboard_seq.CURRVAL FROM DUAL" }, keyProperty = "boardnum", resultType = int.class, before = false)
	int reviewWrite(HashMap<String, String> params);

	@Select("SELECT * FROM reviewboard WHERE boardNum = #{param1}")
	BoardDTO reviewDetail(int boardNum);

	@Select("SELECT newfilename, orifilename FROM photo WHERE divisionnum = #{boardNum}")
	ArrayList<PhotoDTO> callPhoto(int boardNum);

	@Update("UPDATE reviewboard SET delcheck = 'Y' WHERE boardnum = #{boardNum}")
	int reviewDel(int boardNum);

	// @Select("SELECT * FROM reviewboard WHERE delcheck = 'N' ORDER BY boardnum
	// DESC")
	@Select("SELECT rnum, BOARDNUM, ID, CONTENT, TITLE, DATES, BOARDHIT\r\n" + 
			"FROM\r\n" + 
			"(SELECT row_number() OVER(ORDER BY boardnum DESC) rnum,BOARDNUM,ID,CONTENT,TITLE,DATES,BOARDHIT,DELCHECK,DIVISION FROM reviewboard WHERE delcheck = 'N') OFFSET #{param1} ROWS FETCH FIRST 10 ROWS ONLY")
	ArrayList<BoardDTO> reviewList(int page);

	@Update("UPDATE reviewboard SET title = #{param1}, content = #{param2} WHERE boardnum = #{param3}")
	int reviewUpdate(String title, String content, int boardNum);

	@Update("UPDATE photo SET newfilename = #{param1}, orifilename = #{param2} WHERE divisionnum = #{param3}")
	void reviewPhotoUpdate(String neww, String ori, int boardNum);

	@Delete("DELETE photo WHERE newfilename= #{param1} AND divisionnum = #{param2}")
	void photoDel(String newFileName, int boardNum);

	@Update("UPDATE reviewboard SET boardhit = boardhit+1 WHERE boardNum = #{param1}")
	void reviewHit(int boardNum);

	@Insert("INSERT INTO reviewreport(reviewReportNum, boardNum, reporter, reason) VALUES(reviewReport_seq.NEXTVAL, #{boardNum}, #{loginId}, #{reason})")
	void reviewReport(HashMap<String, String> map);

	@Select("SELECT COUNT(boardnum) FROM reviewboard where delcheck='N'")
	int total();


	 

}
