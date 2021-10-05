package com.gudi.main.alarm.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.*;

import com.gudi.main.dtoAll.AlarmDTO;

@Mapper
public interface AlarmMapper {

    //content에는 댓글(cm)인지 조아요(good)으로 구분
    @Insert("INSERT INTO alarm(alarmNum,id,division,content,divisionNum,writeId) VALUES(alarm_seq.NEXTVAL,#{param1},#{param3},#{param4},#{param2},(select Id from ${param3}board where boardnum = #{param2}))")
    void insert(String loginId, String contentId, String division, String cm);

    @Delete("DELETE FROM alarm WHERE divisionNum=#{param1} AND division=#{param2} AND id=#{param3} AND content='good'")
    void goodDelete(String contentId, String division, String loginId);

    //테스트 성공시 나중에 뒤에 붙히기(and id != writeid) 자기자신이 누르고 쓴것은 안가져오게
    @Select("select * from alarm where writeId = #{param1} and alarmCheck = '0'")
    ArrayList<AlarmDTO> read(String loginId);

    @Select("select alarmnum,id,content,division,divisionnum from alarm where writeId = #{param1} and alarmcheck = '0'")
    ArrayList<AlarmDTO> detail(String loginId);

    @Update("update alarm set alarmcheck = '1' where writeId = #{param1}")
    boolean update(String loginId);

    @Delete("DELETE FROM alarm WHERE divisionNum=#{param1} AND division=#{param2} AND id=#{param3} AND content='cm'")
    void cmDelete(String contentId, String division, String loginId);
}
