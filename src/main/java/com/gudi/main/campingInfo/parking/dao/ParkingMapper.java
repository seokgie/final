package com.gudi.main.campingInfo.parking.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.gudi.main.dtoAll.CampingDTO;
import com.gudi.main.dtoAll.GoodDTO;
import com.gudi.main.dtoAll.ParkingDTO;

@Mapper
public interface ParkingMapper {
	
//	@Select("SELECT * FROM ( " +
//			"SELECT ( 6371 * acos( cos( radians( #{param1} ) ) * cos( radians( latitude) ) * cos( radians( longitude ) - radians(#{param2}) ) + sin( radians(#{param1}) ) * sin( radians(latitude) ) ) ) AS distance, prkplcese, lnmadr, prkcmprt, parkingchrgeinfo, operday, institutionnm, phonenumber, prkplcenm, rdnmadr, latitude, longitude " +
//			"FROM parkingapi " +
//			") DATA " +
//			"WHERE DATA.distance < 7")
	/*
	@Select("SELECT distance, prkplcese, lnmadr, prkcmprt, parkingchrgeinfo,operday, institutionnm, phonenumber, prkplcenm, rdnmadr, latitude, longitude, prknum \r\n" + 
			"FROM (SELECT * FROM ( SELECT ( 6371 * acos( cos( radians( #{param1} ) ) * cos( radians( \r\n" + 
			"latitude) ) * cos( radians( longitude ) - radians(#{param2}) ) + sin( radians(#{param1}) \r\n" + 
			") * sin( radians(latitude) ) ) ) AS distance, prkplcese, lnmadr, prkcmprt, parkingchrgeinfo, \r\n" + 
			"operday, institutionnm, phonenumber, prkplcenm, rdnmadr, latitude, longitude, prknum FROM prkapi \r\n" + 
			") DATA WHERE DATA.distance < 5")
	*/
	
	@Select("SELECT * FROM ( " +
			"SELECT ( 6371 * acos( cos( radians( #{param1} ) ) * cos( radians( latitude ) ) * cos( radians( longitude ) - radians(#{param2}) ) + sin( radians(#{param1}) ) * sin( radians(latitude) ) ) ) AS distance, prkplcese, lnmadr, prkcmprt, parkingchrgeinfo,operday, institutionnm, phonenumber, prkplcenm, rdnmadr, latitude, longitude, prknum " +
			"FROM prkapi " +
			") DATA " +
			"WHERE DATA.distance < 5")
	ArrayList<ParkingDTO> getZapyo(String wido, String kyongdo);

	@Select("SELECT * FROM prkapi WHERE prknum = #{param1}")
	ParkingDTO freeParkDetail(String prknum);

	@Select("SELECT rnum, cnt, divisionnum \r\n" + 
			"FROM(SELECT row_number() OVER (ORDER BY cnt desc) rnum, cnt, divisionnum FROM (SELECT COUNT(divisionnum)cnt, divisionnum FROM good WHERE division='parking' GROUP BY divisionnum) ORDER BY cnt DESC)\r\n" + 
			"WHERE rnum BETWEEN 1 AND 7")
	ArrayList<GoodDTO> callRank();
	
	@Select("SELECT prkplcenm FROM prkapi WHERE prknum = #{param1}")
	String searchPrkName(String divisionNum);
	
	
	//유료차박
	@Select("SELECT * FROM ( " +
			"SELECT ( 6371 * acos( cos( radians( #{param1} ) ) * cos( radians( mapy ) ) * cos( radians( mapx ) - radians(#{param2}) ) + sin( radians(#{param1}) ) * sin( radians(mapy) ) ) ) AS distance, contentid, facltnm, addr1, mapx, mapy, tel, lctcl, homepage, induty " +
			"FROM campingapi " +
			") DATA " +
			"WHERE DATA.distance < 10 AND induty like '%자동차%'")
	ArrayList<CampingDTO> payZapyo(String wido, String kyongdo);

	@Select("SELECT facltNm FROM campingapi WHERE contentid = #{param1}")
	String searchPayPrkName(String divisionNum);
	
	/*
	@Select("SELECT rnum, cnt, divisionnum \r\n" + 
			"FROM(SELECT row_number() OVER (ORDER BY cnt desc) rnum, cnt, divisionnum FROM (SELECT COUNT(divisionnum)cnt, divisionnum FROM good WHERE division='camping' GROUP BY divisionnum) ORDER BY cnt DESC)\r\n" + 
			"WHERE rnum BETWEEN 1 AND 10")
	ArrayList<GoodDTO> callPayRank();
	*/
	
	@Select("SELECT * FROM\r\n" + 
			"(SELECT cnt, divisionnum\r\n" + 
			"FROM(SELECT cnt, divisionnum FROM \r\n" + 
			"(SELECT COUNT(divisionnum)cnt, divisionnum FROM good WHERE division='camping' GROUP BY divisionnum)\r\n" + 
			"ORDER BY cnt DESC))\r\n" + 
			"WHERE divisionnum IN (SELECT contentid FROM campingapi WHERE induty LIKE '%자동차%') AND ROWNUM <=7")
	ArrayList<GoodDTO> callPayRank();
	




	
	
	
	
}
