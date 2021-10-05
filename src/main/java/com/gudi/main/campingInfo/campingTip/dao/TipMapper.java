package com.gudi.main.campingInfo.campingTip.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface TipMapper {
	
	@Select("select count (contentId) from campingApi")
	int test();
	
}
