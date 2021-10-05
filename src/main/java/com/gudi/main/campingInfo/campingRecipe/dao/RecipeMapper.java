package com.gudi.main.campingInfo.campingRecipe.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface RecipeMapper {
	
	@Select("select count (contentId) from campingApi")
	int test();
	
}
