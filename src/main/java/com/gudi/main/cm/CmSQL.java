package com.gudi.main.cm;

import org.apache.ibatis.jdbc.SQL;

public class CmSQL {
    public static final String CM_INSERT = "INSERT INTO cm(cmNum,id,division,content,delCheck,divisionNum)" +
            "VALUES(cm_seq.NEXTVAL,#{param1},#{param4},#{param2},'N',#{param3})";
    public static final String CM_LIST = "SELECT * FROM cm WHERE division = #{param2} AND divisionNum = #{param1} AND delCheck='N' ORDER BY cmNum DESC" +
            " OFFSET #{param3} ROWS FETCH FIRST 8 ROWS ONLY";
    public static final String CM_PAGECHECK = "SELECT cmNum FROM" +
            "(SELECT cmNum FROM cm WHERE division = #{param2} AND divisionNum = #{param1} AND delCheck='N'" +
            "ORDER BY cmNum DESC OFFSET #{param4} ROWS FETCH FIRST 8 ROWS ONLY)" +
            "WHERE cmNum=#{param3}";
    public static final String CM_REPORT_INSERT = "INSERT INTO cmReport(cmReportNum,cmNum,reporter,status,reason) " +
            "VALUES(cmReport_seq.NEXTVAL,#{cmNum},#{reporter},'N',#{reason})";

}
