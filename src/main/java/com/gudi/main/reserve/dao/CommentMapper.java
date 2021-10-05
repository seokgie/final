package com.gudi.main.reserve.dao;

import com.gudi.main.dtoAll.CommentDTO;
import org.apache.ibatis.annotations.*;

import java.util.ArrayList;

@Mapper
public interface CommentMapper {

    @Select(ReserveSQL.CM_LIST)
    ArrayList<CommentDTO> cmList(String contentId, String division, int page);

    @Select("SELECT COUNT(cmNum) FROM cm WHERE division = 'camping' AND divisionNum = #{param1} AND delCheck='N'")
    int reserveTotal(String contentId);

    @Insert(ReserveSQL.CM_INSERT)
    int reserveCmInsert(String loginId, String commentContent, String contentId);

    @Select(ReserveSQL.CM_PAGECHECK)
    String cmPageCheck(String contentId, String division, int cmNum, int start);

    @Update("UPDATE cm SET content = #{param2} WHERE cmNum = #{param1}")
    void reserveCmUpdate(String cmNum, String cmUpdateContent);

    @Update("UPDATE cm SET delCheck = 'Y' WHERE cmNum = #{cmNum}")
    void cmDelete(String cmNum);
}
