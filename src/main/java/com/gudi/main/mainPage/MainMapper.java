package com.gudi.main.mainPage;

import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.dtoAll.CampingDTO;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;

import java.util.ArrayList;

@Mapper
public interface MainMapper {

    @SelectProvider(type = MainSQL.class, method = "locationPlusTotal")
    int total(String location);

    @SelectProvider(type = MainSQL.class, method = "locationPlusList")
    ArrayList<CampingDTO> locationList(String location, int start);

    @Select(MainSQL.GOOD_LIST)
    ArrayList<MainDTO> goodList(int month);

    @SelectProvider(type = MainSQL.class, method = "boardList")
    ArrayList<BoardDTO> BoardList(String board);

    @Delete("DELETE FROM campingApi")
    int apiDelete();

    @Delete("DELETE FROM campingApi WHERE intro IS NULL OR firstImageUrl IS NULL OR themaEnvrncl IS NULL")
    void apiFilter();
}
