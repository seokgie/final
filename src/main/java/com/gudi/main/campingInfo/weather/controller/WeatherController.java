package com.gudi.main.campingInfo.weather.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.gudi.main.campingInfo.weather.service.WeatherService;

@Controller
@RequestMapping(value = "/campingInfo")
public class WeatherController {
    Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Autowired WeatherService service;

    @RequestMapping(value = "/campingWeather")
    public String list(Model model) {
        return "campingInfo/campingWeather/campingWeatherMain";
    }
    
 
    
    
    
}
