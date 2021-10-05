package com.gudi.main.campingInfo.weather.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gudi.main.campingInfo.weather.dao.WeatherMapper;

@Service
public class WeatherService {
	
	@Autowired WeatherMapper mapper;

	public void test() {
		
		int weather = mapper.test();
		System.out.println(weather);
		
	}
	
}
