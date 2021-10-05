package com.gudi.main.campingInfo.weather.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface WeatherMapper {
	
	@Select ("SELECT count(contentid) from campingApi")
	int test();
	 
	
	
}
