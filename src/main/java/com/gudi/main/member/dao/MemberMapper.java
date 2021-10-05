package com.gudi.main.member.dao;

import com.gudi.main.dtoAll.MemberDTO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.ArrayList;
import java.util.HashMap;

public interface MemberMapper {

    @Select("SELECT id FROM member WHERE id=#{id}")
    String idCheck(String id);

    @InsertProvider(type = MemberSQL.class, method = "nullCheck")
    int join(HashMap<String, String> map);

    @Select("SELECT pw FROM member WHERE id=#{id} AND delCheck='N'")
    String login(String inputId);


    @Select("SELECT id FROM member WHERE email=#{email} AND nickname=#{nickName} AND delCheck='N'")
    ArrayList<String> idFind(HashMap<String, String> params);

    @Select("SELECT id FROM member WHERE email=#{email} AND id=#{id}")
    String passFind(HashMap<String, String> params);

    @Update("UPDATE member SET pw=#{param1} WHERE id=#{param2}")
    void passChange(String enc_pass, String id);

    @Select("SELECT admin FROM member WHERE id = #{param1}")
    String adminCheck(String inputId);
}
