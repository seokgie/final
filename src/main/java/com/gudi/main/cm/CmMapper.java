package com.gudi.main.cm;

import com.gudi.main.dtoAll.CommentDTO;
import com.gudi.main.reserve.dao.ReserveSQL;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.ArrayList;
import java.util.HashMap;

@Mapper
public interface CmMapper {
    @Select(CmSQL.CM_LIST)
    ArrayList<CommentDTO> cmList(String contentId, String division, int page);

    @Select("SELECT COUNT(cmNum) FROM cm WHERE division = #{param2} AND divisionNum = #{param1} AND delCheck='N'")
    int cmTotal(String contentId, String division);

    @Insert(CmSQL.CM_INSERT)
    int cmInsert(String loginId, String commentContent, String contentId, String division);

    @Select(CmSQL.CM_PAGECHECK)
    String cmPageCheck(String contentId, String division, int cmNum, int start);

    @Update("UPDATE cm SET content = #{param2} WHERE cmNum = #{param1}")
    void cmUpdate(String cmNum, String cmUpdateContent);

    @Update("UPDATE cm SET delCheck = 'Y' WHERE cmNum = #{cmNum}")
    void cmDelete(String cmNum);

    @Insert(CmSQL.CM_REPORT_INSERT)
    void cmReport(HashMap<String, String> params);
}
