package com.gudi.main.reserve.service;

import com.gudi.main.dtoAll.BoardDTO;
import com.gudi.main.dtoAll.CampingDTO;
import com.gudi.main.dtoAll.CommentDTO;
import com.gudi.main.dtoAll.ReserveDTO;
import com.gudi.main.reserve.dao.ReserveMapper;
import com.gudi.main.util.ApiUtil;
import com.gudi.main.util.HansolUtil;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;

@Service
public class ReserveService {
    @Autowired
    ReserveMapper mapper;
    @Autowired
    CommentService commentService;
    Logger logger = LoggerFactory.getLogger(this.getClass());

    public HashMap<String, Object> campingDetail(String contentId, HttpSession session) {
        // 디테일 정보 가져오기
        CampingDTO dto = mapper.campingDetail(contentId);
        // url 선언
        String url = "http://api.visitkorea.or.kr/openapi/service/rest/GoCamping/imageList";
        // params 선언
        String params = "ServiceKey=YRc1yhIuj%2BSEq19P4LqBXRmFAtACpby0jiZKx%2BpSOyMnQ%2B5EX18dxJ%2BheYZ%2B4Ls%2FhYTVS6%2BFqoIZDjj2XmsmRg%3D%3D" +
                "&MobileOS=ETC&MobileApp=final_project&_type=json&contentId=" + contentId;
        // urls 어레이리스트에 담기
        ArrayList<String> urls = new ArrayList<String>();
        urls.add(url);
        // 헤더값 담기
        HashMap<String, String> headers = new HashMap<String, String>();
        headers.put("Content-type", "application/json");
        // 결과 json 반환
        String result = ApiUtil.sendSeverMsg(urls, headers, params, "get");
        // 해체쇼 및 배열에 담기
        ArrayList<HashMap<String, Object>> hashMapArrayList = jsonResult(result);
        System.out.println(hashMapArrayList.size());
        // 이미지 배열에 옮기기
        ArrayList<String> imgArr = new ArrayList<String>();
        if (hashMapArrayList.size() >= 3) {
            for (int i = 0; i < 3; i++) {
                imgArr.add((String) hashMapArrayList.get(i).get("imageUrl"));
            }
        }
        // 댓글값 가져오기(페이지네이션 포함)
        HashMap<String, Object> map = commentService.commentList(contentId, "camping", 1);
        String loginId = (String) session.getAttribute("loginId");
        // 좋아요 체크
        String goodNum = null;
        if (loginId != null) {
            goodNum = mapper.goodCheck(loginId, "camping", contentId);
        }
        if (goodNum == null) {
            map.put("goodCheck", false);
        } else {
            map.put("goodCheck", true);
        }
        // 좋아요 갯수
        int goodCount = mapper.campingGoodCount("camping", contentId);
        map.put("imgArr", imgArr);
        map.put("goodCount", goodCount);
        map.put("dto", dto);
        return map;
    }


    // 캠핑장 이미지 API 결과값 해체쇼 및 배열반환
    public ArrayList<HashMap<String, Object>> jsonResult(String jsonString) {
        // 해체쇼
        JSONObject jsonObject1 = ApiUtil.jsonStringToJson(jsonString);
        JSONObject jsonObject2 = ApiUtil.jsonStringToJson(jsonObject1.get("response"));
        JSONObject jsonObject3 = ApiUtil.jsonStringToJson(jsonObject2.get("body"));
        JSONObject jsonObject4 = ApiUtil.jsonStringToJson(jsonObject3.get("items"));
        // 배열화
        ArrayList<HashMap<String, Object>> hashMapArrayList = ApiUtil.jsonArray(jsonObject4.get("item"));
        return hashMapArrayList;
    }

    public ArrayList<String> campingReserveList(String contentId) {
        return mapper.campingReserveList(contentId);
    }

    public void campingReserveInsert(HashMap<String, String> params, String loginId, String contentId) {
            mapper.campingReserveInsert(params,loginId,contentId);
    }
}
