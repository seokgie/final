package com.gudi.main.campingServiceCenter.noticeBoard.dao;

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
public interface NoticeMapper {
	
	/*
	 * @Select("SELECT rnum, boardnum,id, title, content,  boardhit, dates FROM (SELECT  ROW_NUMBER() OVER ( ORDER BY boardnum desc) rnum, boardnum,id, title, content,  boardhit, dates,  delcheck  FROM  noticeboard where delcheck = 'N') WHERE rnum BETWEEN #{param1} AND #{param2}"
	 * ) ArrayList<BoardDTO> list(int start, int end);
	 * 
	 * @Select("select count(boardnum) from (SELECT  ROW_NUMBER() OVER ( ORDER BY boardnum desc)  rnum, boardnum, id, title, content,  boardhit, dates, delcheck  FROM  noticeboard where delcheck = 'N')"
	 * ) int allCount();
	 */

	@Update("update noticeboard set boardhit = boardhit + 1 where boardnum = #{boardnum}")
	void up(int boardNum);

	@Select("select * from noticeboard where boardnum = #{boardnum}")
	BoardDTO detail(int boardNum);

	@Select("SELECT photonum, newFileName, oriFileName, id, dates FROM photo WHERE division = 'notice' and divisionnum = #{boardnum}")
	ArrayList<PhotoDTO> file(int boardNum);

	@Insert("INSERT INTO photo(photonum, id, division, newfilename, orifilename, divisionnum) VALUES (photo_seq.NEXTVAL, #{param4}, 'notice', #{param1}, #{param2}, #{param3})")
	void noticePhoto(String neww, String ori, String boardNum, String loginId);

	@Insert("INSERT INTO noticeboard(boardnum, id, title, content, delcheck) VALUES (noticeboard_seq.NEXTVAL, #{id}, #{title}, #{content}, 'N')")
	@SelectKey(statement = {"SELECT noticeboard_seq.CURRVAL FROM DUAL"}, keyProperty = "boardnum",resultType = int.class, before = false)
	int noticeWrite(HashMap<String, String> params);

	@Select("SELECT newfilename, orifilename FROM photo WHERE division = 'notice' AND divisionnum = #{param1}")
	ArrayList<PhotoDTO> callPhoto(int boardNum);

	@Update("UPDATE noticeboard SET delcheck = 'Y' WHERE boardnum = #{boardNum} ")
	int noticeDel(int boardNum);

	@Update("UPDATE noticeboard SET title = #{param1}, content = #{param2} WHERE boardnum = #{param3}")
	int noticeUpdate(String title, String content, int boardNum);

	@Delete("DELETE photo WHERE newfilename= #{param1} AND division = 'notice' AND divisionnum = #{param2}")
	void photoDel(String newFileName, int boardNum);

	@Select("SELECT COUNT(boardnum) FROM noticeboard where delcheck='N'")
	int total();

	@Select("SELECT rnum, boardnum,id, title, content,  boardhit, dates FROM (SELECT  ROW_NUMBER() OVER ( ORDER BY boardnum desc) rnum, boardnum,id, title, content,  boardhit, dates,  delcheck  FROM  noticeboard where delcheck = 'N') OFFSET #{param1} ROWS FETCH FIRST 10 ROWS ONLY ")
	ArrayList<BoardDTO> lists(int page);

}
