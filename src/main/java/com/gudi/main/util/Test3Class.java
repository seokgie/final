package com.gudi.main.util;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

public class Test3Class {
   public static void main(String args[]) {
       System.out.println("일하라고오오오오ㅗㅗ");

       /*
       HashMap<String, String> map = new HashMap<String, String>();

       String url = "http://api.data.go.kr/openapi/tn_pubr_prkplce_info_api";
       String params = "serviceKey=vEhq3s5%2BNYg8x9IUIlZEUQBxNj%2Bm2tHa5AhL5FlmJTY%2B7LNpXIUsvzXV2NUvV7SoHcNTlR%2FZKMM99hOYgBVygA%3D%3D&pageNo=8&numOfRows=500&type=json&prkplceSe=공영&parkingchrgeInfo=무료&prkplceType=노외";
       // urls 어레이리스트에 담기
       ArrayList<String> urls = new ArrayList<String>();
       urls.add(url);

       // 헤더값 담기
       HashMap<String, String> headers = new HashMap<String, String>();
       headers.put("Content-type", "application/json");

       String result = ApiUtil.sendSeverMsg(urls, headers, params, "get");


       System.out.println(result);
       JSONObject jsonObject1 = ApiUtil.jsonStringToJson(result);
       JSONObject jsonObject2 = ApiUtil.jsonStringToJson(jsonObject1.get("response"));
       JSONObject jsonObject3 = ApiUtil.jsonStringToJson(jsonObject2.get("body"));

       //배열화
       ArrayList<HashMap<String, Object>> mapp = ApiUtil.jsonArray(jsonObject3.get("items"));
       System.out.println((String) mapp.get(0).get("prkplceSe"));
       System.out.println(mapp.size());

       Connection conn = null;
       PreparedStatement pstmt = null;

       String sql = "INSERT INTO prkapi(PRKPLCESE,lnmadr,PRKCMPRT,PARKINGCHRGEINFO,OPERDAY,INSTITUTIONNM,PHONENUMBER,LATITUDE,LONGITUDE,prkplceNm,rdnmadr,prknum) "+
               "VALUES(?,?,?,?,?,?,?,?,?,?,?,prk_seq.nextval)";

       try {
           Class.forName("net.sf.log4jdbc.DriverSpy");
           conn = DriverManager.getConnection("jdbc:log4jdbc:oracle:thin:@61.78.121.242:1521:xe", "C##Modakbul_2", "pass");

           pstmt = conn.prepareStatement(sql);

           for (int i = 0; i < mapp.size(); i++) {

               System.out.println("몇번째???:: "+i);

               pstmt.setString(1, mapp.get(i).get("prkplceSe").toString());
               pstmt.setString(2, mapp.get(i).get("lnmadr").toString());
               pstmt.setString(3, mapp.get(i).get("prkcmprt").toString());
               pstmt.setString(4, mapp.get(i).get("parkingchrgeInfo").toString());
               pstmt.setString(5, mapp.get(i).get("operDay").toString());
               pstmt.setString(6, mapp.get(i).get("institutionNm").toString());
               pstmt.setString(7, mapp.get(i).get("phoneNumber").toString());
               pstmt.setString(8, mapp.get(i).get("latitude").toString());
               pstmt.setString(9, mapp.get(i).get("longitude").toString());
               pstmt.setString(10, mapp.get(i).get("prkplceNm").toString());
               pstmt.setString(11, mapp.get(i).get("rdnmadr").toString());

               // Batch 실행
               pstmt.executeUpdate();
           }
           // 커밋
           conn.commit();

       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           if (pstmt != null) try {
               pstmt.close();
               pstmt = null;
           } catch (SQLException ex) {
           }
           if (conn != null) try {
               conn.close();
               conn = null;
           } catch (SQLException ex) {
           }
       }

        */
   }
   
}
