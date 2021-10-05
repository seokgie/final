package com.gudi.main.good;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface GoodMapperCommon {
    @Select("SELECT goodNum FROM good WHERE divisionNum=#{param1} AND division=#{param2} AND id=#{param3}")
    String goodCheck(String contentId, String division, String loginId);

    @Insert("INSERT INTO good(goodNum,divisionNum,division,id) VALUES(good_seq.NEXTVAL,#{param1},#{param2},#{param3})")
    void goodInsert(String contentId, String division, String loginId);

    @Delete("DELETE FROM good WHERE divisionNum=#{param1} AND division=#{param2} AND id=#{param3}")
    void goodDelete(String contentId, String division, String loginId);

    @Select("SELECT COUNT(goodNum) FROM good WHERE divisionNum=#{param1} AND division=#{param2}")
    int goodCount(String contentId, String division);
}
