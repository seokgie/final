package com.gudi.main.reserve.dao;

import com.gudi.main.dtoAll.CampingDTO;
import com.gudi.main.dtoAll.CommentDTO;
import com.gudi.main.dtoAll.ReserveDTO;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.InsertProvider;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.ArrayList;
import java.util.HashMap;

@Mapper
public interface ReserveMapper {

    @Select("SELECT * FROM campingApi WHERE contentId = #{param1}")
    CampingDTO campingDetail(String contentId);

    @Select("SELECT goodNum FROM good WHERE id=#{param1} AND division=#{param2} AND divisionNum=#{param3}")
    String goodCheck(String loginId, String camping, String contentId);

    @Select("SELECT COUNT(goodNum) FROM good WHERE division=#{param1} AND divisionNum=#{param2}")
    int campingGoodCount(String camping, String contentId);

    @Select("SELECT reserveDate FROM reserve WHERE contentId=#{contentId}")
    ArrayList<String> campingReserveList(String contentId);

    @InsertProvider(type = ReserveSQL.class, method = "reserveNull")
    int campingReserveInsert(HashMap<String, String> params, String loginId, String contentId);
}
