package com.gudi.main.myInfo.dao;

import java.util.ArrayList;

import com.gudi.main.dtoAll.*;
import com.gudi.main.myInfo.dto.MyInfoDTO;
import org.apache.ibatis.annotations.*;

@Mapper
public interface MyInfoMapper {

    @Select("SELECT * FROM member WHERE id=#{param1}")
    MemberDTO myInfoData(String loginId);

    @Update("UPDATE member SET nickName=#{param2} WHERE id=#{param1}")
    void infoUpdate(String loginId, String nickName);

    @Select("SELECT pw FROM member WHERE id=#{param1}")
    String pwCheck(String loginId);

    @Update("UPDATE member SET pw = #{param1} WHERE id =#{param2}")
    void pwUpdate(String enc_pass, String loginId);

    @Update("UPDATE member SET delCheck = 'Y' WHERE id = #{param1}")
    void memberDropReal(String loginId);

    @Select("SELECT c.contentId,r.reserveNum,c.facltNm,r.manCount,r.carNum,r.reserveDate FROM " +
            "campingApi c RIGHT OUTER JOIN reserve r ON c.contentId = r.contentId " +
            "WHERE r.id = #{param1} ORDER BY r.reserveNum DESC OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
    ArrayList<MyInfoDTO> reserveList(String loginId, int start);

    @Select("SELECT COUNT(reserveNum) FROM reserve WHERE id=#{param1}")
    int reserveTotal(String loginId);

    @Delete("DELETE FROM reserve WHERE reserveNum = #{param1}")
    void reserveCancel(int reserveNum);

    @Select("SELECT COUNT(cmNum) FROM cm WHERE id = #{param1} AND division = #{param2} AND delCheck='N'")
    int myCmTotal(String loginId, String division);

    /*@Select("SELECT * FROM cm WHERE id = #{param1} AND division = #{param3} ORDER BY cmNum DESC OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")*/
    @SelectProvider(type = MyInfoSQL.class, method = "boardCheck")
    ArrayList<CommentDTO> myCmList(String loginId, int start, String division);

    @Select("SELECT COUNT(boardNum) FROM ${param2} WHERE id = #{param1}")
    int myBoardTotal(String loginId, String division);

    @Select("SELECT * FROM ${param3} WHERE id = #{param1} ORDER BY boardNum DESC OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
    ArrayList<BoardDTO> reviewList(String loginId, int start, String division);

    @Select("SELECT COUNT(goodNum) FROM good WHERE id=#{param1} AND division='camping'")
    int wantToGoTotal(String loginId);

    @Select("SELECT contentID,facltnm,lineIntro,addr1 FROM campingApi c LEFT OUTER JOIN good g ON " +
            "g.divisionNum = c.contentId WHERE g.id =#{param1} AND g.division = 'camping' " +
            "ORDER BY g.goodNum DESC OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY")
    ArrayList<CampingDTO> wantToGoCampingList(String loginId, int start);

    @Select("SELECT COUNT(cmReportNum) FROM cmReport WHERE reporter = #{param1}")
    int reportCmTotal(String loginId);

    @Select("SELECT c.cmNum,c.status,c.dates,c.reason,cm.content FROM cm LEFT OUTER JOIN cmReport c" +
            " ON cm.cmNum = c.cmNum WHERE reporter = #{param1} ORDER BY cmReportNum DESC OFFSET 0 ROWS FETCH FIRST 15 ROWS ONLY")
    ArrayList<CommentReportDTO> reportCmList(String loginId, int start);
}
