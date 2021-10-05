package com.gudi.main.reserve.dao;

import com.gudi.main.dtoAll.ReserveDTO;
import org.apache.ibatis.jdbc.SQL;

import java.util.HashMap;

public class ReserveSQL {
    public static final String CM_INSERT = "INSERT INTO cm(cmNum,id,division,content,delCheck,divisionNum)" +
            "VALUES(cm_seq.NEXTVAL,#{param1},'camping',#{param2},'N',#{param3})";
    public static final String CM_LIST = "SELECT * FROM cm WHERE division = #{param2} AND divisionNum = #{param1} AND delCheck='N' ORDER BY cmNum DESC" +
            " OFFSET #{param3} ROWS FETCH FIRST 8 ROWS ONLY";
    public static final String CM_PAGECHECK = "SELECT cmNum FROM" +
            "(SELECT cmNum FROM cm WHERE division = #{param2} AND divisionNum = #{param1} AND delCheck='N'" +
            "ORDER BY cmNum DESC OFFSET #{param4} ROWS FETCH FIRST 8 ROWS ONLY)" +
            "WHERE cmNum=#{param3}";

    public String reserveNull(HashMap<String, String> params, String loginId, String contentId) {
        return new SQL() {{
            INSERT_INTO("reserve");
            INTO_COLUMNS("reserveNum", "contentId", "id", "phone", "reserveDate", "delCheck", "reserveName");
            INTO_VALUES("reserve_seq.NEXTVAL", "'" + contentId + "'", "'" + loginId + "'",
                    "'" + params.get("phone") + "'", "'" + params.get("reserveDate") + "'", "'N'", "'" + params.get("reserveName") + "'");
            if (params.get("manCount").equals("")) {
                INTO_COLUMNS("manCount");
                INTO_VALUES("'없음'");
            } else {
                INTO_COLUMNS("manCount");
                INTO_VALUES("'" + params.get("manCount") + "'");
            }
            if (params.get("carNum").equals("")) {
                INTO_COLUMNS("carNum");
                INTO_VALUES("'없음'");
            } else {
                INTO_COLUMNS("carNum");
                INTO_VALUES("'" + params.get("carNum") + "'");
            }
        }}.toString();
    }
}
