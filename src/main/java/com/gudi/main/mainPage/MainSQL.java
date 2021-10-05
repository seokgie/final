package com.gudi.main.mainPage;

import com.gudi.main.dtoAll.ReserveDTO;
import org.apache.ibatis.jdbc.SQL;

public class MainSQL {
    public static final String GOOD_LIST = "SELECT firstImageUrl,contentId,facltNm,themaEnvrnCl,goodCount FROM(SELECT firstImageUrl,contentId,facltNm,themaEnvrnCl,goodCount"
            + " FROM(SELECT firstImageUrl,contentId,facltNm,themaEnvrnCl,(SELECT COUNT(goodNum) FROM good WHERE divisionNum = contentId AND dates LIKE '%'||#{month}||'%') goodCount FROM campingApi)"
            + "WHERE goodCount > 0 ORDER BY goodCount DESC) WHERE ROWNUM <= 4";

    public String boardList(String board) {
        return new SQL() {{
            SELECT("*");
            FROM("("+new SQL() {{
                SELECT("*");
                FROM(board);
                WHERE("delCheck='N'");
                ORDER_BY("boardNum DESC");
            }}.toString()+")");
            WHERE("ROWNUM <= 7");
        }}.toString();
    }

    public String locationPlusTotal(String location) {
        return new SQL() {{
            SELECT("COUNT(contentId)");
            FROM("campingApi");
            WHERE("addr1 LIKE '%'|| #{param1} ||'%'");
            switch (location) {
                case "경남":
                    OR();
                    WHERE("addr1 LIKE '%'|| '경상남도' ||'%'");
                    break;
                case "경북":
                    OR();
                    WHERE("addr1 LIKE '%'|| '경상북도' ||'%'");
                    break;
                case "전북":
                    OR();
                    WHERE("addr1 LIKE '%'|| '전라북도' ||'%'");
                    break;
                case "전남":
                    OR();
                    WHERE("addr1 LIKE '%'|| '전라남도' ||'%'");
                    break;
                case "충남":
                    OR();
                    WHERE("addr1 LIKE '%'|| '충청남도' ||'%'");
                    break;
                case "충북":
                    OR();
                    WHERE("addr1 LIKE '%'|| '충청북도' ||'%'");
                    break;
            }
        }}.toString();
    }

    public String locationPlusList(String location) {
        return new SQL() {{
            SELECT("*");
            FROM("campingApi");
            WHERE("addr1 LIKE '%'|| #{param1} ||'%'");
            switch (location) {
                case "경남":
                    OR();
                    WHERE("addr1 LIKE '%'|| '경상남도' ||'%'");
                    break;
                case "경북":
                    OR();
                    WHERE("addr1 LIKE '%'|| '경상북도' ||'%'");
                    break;
                case "전북":
                    OR();
                    WHERE("addr1 LIKE '%'|| '전라북도' ||'%'");
                    break;
                case "전남":
                    OR();
                    WHERE("addr1 LIKE '%'|| '전라남도' ||'%'");
                    break;
                case "충남":
                    OR();
                    WHERE("addr1 LIKE '%'|| '충청남도' ||'%'");
                    break;
                case "충북":
                    OR();
                    WHERE("addr1 LIKE '%'|| '충청북도' ||'%'");
                    break;
            }
            ORDER_BY("contentId DESC");
        }}.toString() + " OFFSET #{param2} ROWS FETCH FIRST 6 ROWS ONLY";
    }
}
