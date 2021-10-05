package com.gudi.main.member.dao;

import org.apache.ibatis.jdbc.SQL;

import java.util.HashMap;

public class MemberSQL {

    public String nullCheck(HashMap<String, String> map) {
        return new SQL() {{
            INSERT_INTO("member");
            INTO_COLUMNS("id", "pw", "email", "admin", "delCheck");
            INTO_VALUES("'" + map.get("id") + "'", "'" + map.get("pw") + "'", "'" + map.get("email") + "'", "'N'", "'N'");
            if (map.get("nickName").equals("")) {
                INTO_COLUMNS("nickName");
                INTO_VALUES("'없음'");
            } else {
                INTO_COLUMNS("nickName");
                INTO_VALUES("'" + map.get("nickName") + "'");
            }
        }}.toString();
    }
}
