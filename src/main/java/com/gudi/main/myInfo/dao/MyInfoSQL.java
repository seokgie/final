package com.gudi.main.myInfo.dao;

import org.apache.ibatis.jdbc.SQL;

public class MyInfoSQL {

    public String boardCheck(String loginId, int start, String division) {
        return new SQL() {{
            switch (division) {
                case "review":
                    SELECT("r.boardNum,r.title,cm.content,cm.dates");
                    FROM("cm");
                    LEFT_OUTER_JOIN("reviewBoard r ON cm.divisionNum = r.boardNum");
                    WHERE("cm.id = #{param1}");
                    WHERE("cm.division='review'");
                    WHERE("cm.delCheck='N'");
                    ORDER_BY("cmNum DESC");
                    break;
                case "free":
                    SELECT("f.boardNum,f.title,cm.content,cm.dates");
                    FROM("cm");
                    LEFT_OUTER_JOIN("freeBoard f ON cm.divisionNum = f.boardNum");
                    WHERE("cm.id = #{param1}");
                    WHERE("cm.division='free'");
                    WHERE("cm.delCheck='N'");
                    ORDER_BY("cmNum DESC");
                    break;
                case "notice":
                    SELECT("n.boardNum,n.title,cm.content,cm.dates");
                    FROM("cm");
                    LEFT_OUTER_JOIN("noticeBoard n ON cm.divisionNum = n.boardNum");
                    WHERE("cm.id = #{param1}");
                    WHERE("cm.division='notice'");
                    WHERE("cm.delCheck='N'");
                    ORDER_BY("cmNum DESC");
                    break;
                case "camping":
                    SELECT("c.contentId,c.facltnm,cm.content,cm.dates");
                    FROM("cm");
                    LEFT_OUTER_JOIN("campingApi c ON cm.divisionNum = c.contentId");
                    WHERE("cm.id = #{param1}");
                    WHERE("cm.division='camping'");
                    WHERE("cm.delCheck='N'");
                    ORDER_BY("cmNum DESC");
                    break;
                case "parking":
                    SELECT("p.prkNum,p.lnmadr,p.prkplceNm,cm.content,cm.dates");
                    FROM("cm");
                    LEFT_OUTER_JOIN("prkApi p ON cm.divisionNum = p.prkNum");
                    WHERE("cm.id = #{param1}");
                    WHERE("cm.division='parking'");
                    WHERE("cm.delCheck='N'");
                    ORDER_BY("cmNum DESC");
                    break;
            }
        }}.toString() + " OFFSET #{param2} ROWS FETCH FIRST 15 ROWS ONLY";
    }
}
