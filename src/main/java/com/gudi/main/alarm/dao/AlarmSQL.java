package com.gudi.main.alarm.dao;

import org.apache.ibatis.jdbc.SQL;

public class AlarmSQL {
    public String cmCheck(String loginId, String contentId, String division, String cm) {
        return new SQL() {{
            INSERT_INTO("alarm");
            INTO_COLUMNS("alarmNum", "id", "division", "content", "divisionNum");
            INTO_VALUES("alarm_seq.NEXTVAL", "#{param1}", "#{param3}", "#{param4}", "#{param2}");
            if (division.equals("parking") || division.equals("camping")) {
                INTO_COLUMNS("writeId");
                INTO_VALUES("#{param3}");
            } else {
                INTO_COLUMNS("writeId");
                INTO_VALUES("(SELECT id FROM ${param3}board WHERE boardNum = #{param2})");
            }
        }}.toString();
    }
}
