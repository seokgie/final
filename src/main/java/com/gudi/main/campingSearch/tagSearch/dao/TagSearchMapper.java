package com.gudi.main.campingSearch.tagSearch.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.gudi.main.dtoAll.CampingDTO;

@Mapper
public interface TagSearchMapper {
	

	@Select("SELECT * FROM campingApi ORDER BY contentId DESC OFFSET #{param1} ROWS FETCH FIRST 10 ROWS ONLY")
	ArrayList<CampingDTO> lists(int page);
	
	@Select("SELECT COUNT(contentId) FROM campingApi")
	int total();

	@Select("SELECT * FROM campingApi where themaEnvrnCl like '%' || #{param2} || '%' ORDER BY contentId DESC OFFSET #{param1} ROWS FETCH FIRST #{param3} ROWS ONLY")
	ArrayList<CampingDTO> search(int page,String word, int cnt);

	@Select("select distinct themaEnvrnCl from  (select * from campingapi   order by dbms_random.value) where rownum <= 10")
	ArrayList<CampingDTO> them();
	
}
