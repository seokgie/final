package com.gudi.main.campingSearch.tagSearch.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.gudi.main.campingSearch.tagSearch.dao.TagSearchMapper;
import com.gudi.main.dtoAll.CampingDTO;
import com.gudi.main.util.HansolUtil;

@Service
public class TagSearchService {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	TagSearchMapper dao;

	public ModelAndView lists(int page) {
		ModelAndView mav = new ModelAndView();
		int total = dao.total();
		HashMap<String, Object> map = HansolUtil.pagination(page, 10, total);
		if (page == 1) {
			page = 0;
		} else {
			page = (page - 1) * 10;
		}
		ArrayList<CampingDTO> list = dao.lists(page);

		ArrayList<CampingDTO> them = dao.them();
		String str = "";
		for (CampingDTO i : them) { // for문을 통한 전체출력
			// System.out.println(i.getThemaEnvrnCl());
			str += i.getThemaEnvrnCl() + ",";
		}
		String[] dataList = str.split(",");
		ArrayList<String> themList = new ArrayList<>();
		for (String data : dataList) {
			if (!themList.contains(data))
				themList.add(data);
		}
		logger.info("테마배열 :" + themList);
		map.put("them", themList);
		map.put("list", list);
		map.put("url", "tagSearch");
		mav.addObject("map", map);
		mav.setViewName("campingSearch/tagSearch/tagSearchMain");
		return mav;
	}

	public ModelAndView search(int page, String word) {
		ModelAndView mav = new ModelAndView();
		int total = dao.total();
		HashMap<String, Object> map = HansolUtil.pagination(page, 10, total);
		if (page == 1) {
			page = 0;
		} else {
			page = (page - 1) * 10;
		}
		ArrayList<CampingDTO> list = new ArrayList<CampingDTO>();
		String[] arr = word.split(",");
		int cnt;
		if(arr.length ==0) {
			mav.setViewName("campingSearch/tagSearch/tagSearch");
			return mav;
		}else if(arr.length == 1) {
			cnt = 10;
		}
		else if (arr.length < 5) {
			cnt = (10 / arr.length) + (5-arr.length);
		} else {
			cnt = (10 / (arr.length - 1)) * 2;
		}
		System.out.println(cnt + " 개 씩 데이터 가져올것 ");

		for (int h = 1; h < arr.length; h++) {
			System.out.println(arr[h]);
			page++;
			ArrayList<CampingDTO> list1 = dao.search(page, arr[h], cnt);
			list.addAll(list1);
		}
		for (int i = 0; i < list.size(); i++) {
			for (int j = 0; j < list.size(); j++) {
				if (i == j) {
				} else if (list.get(j).getContentId() == list.get(i).getContentId()) {
					list.remove(j);
				}
			}
		}
		System.out.println("중복체크후 몇개?" + list.size());
		if(list.size()<10) {
			cnt = 10 - list.size();
			ArrayList<CampingDTO> list1 = dao.search(100, arr[0], cnt);
			list.addAll(list1);
		}
		if (list.size() > 10) {
			for (int k = 10; k < list.size() ; k++) {
				list.remove(k);
				//System.out.println(k+"번 삭제");
			}
			/*
			 * for (int i = 0; i < list.size() ; i++) {
			 * System.out.println(i+"번째"+list.get(i)); }
			 */
		}
		System.out.println(list.size() + "개");
		map.put("list", list);
		map.put("url", "search");
		map.put("word", word);
		mav.addObject("map", map);
		mav.setViewName("campingSearch/tagSearch/tagSearch");
		return mav;
	}
}
