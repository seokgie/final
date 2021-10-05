package com.gudi.main.campingSearch.mapSearch.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.gudi.main.dtoAll.CampingDTO;

@Mapper
public interface MapSearchMapper {

	@Select("SELECT * FROM campingApi where ${param4} like '%' || #{param2} || '%'  and TEL IS NOT NULL ORDER BY contentId DESC OFFSET #{param1} ROWS FETCH FIRST #{param3} ROWS ONLY")
	ArrayList<CampingDTO> list(int page,String word, int cnt, String type);

	@Select("SELECT count(rnum) FROM (SELECT  ROW_NUMBER() OVER ( ORDER BY contentid desc) rnum FROM campingapi where tel IS NOT NULL)")
	int allCount();

	@Select(" SELECT * FROM ( SELECT ( 6371 * acos( cos( radians(#{param1} ) ) * cos( radians( mapy) ) * cos( radians( mapx ) - radians(#{param2}) ) + sin( radians(#{param1}) ) * sin( radians(mapy) ) ) ) "
			+ " AS distance,  contentId,facltNm,addr1,mapX,mapY,tel,firstImageUrl " + " FROM campingapi "
			+ ") DATA " + " WHERE DATA.distance <15 AND tel IS NOT NULL")
	ArrayList<CampingDTO> zapyo(String wido, String kyongdo);

	@Select("SELECT count(contentId) FROM campingApi where ${param2} like '%' || #{param1}|| '%' and TEL IS NOT NULL")
	int total(String word, String type);
}
