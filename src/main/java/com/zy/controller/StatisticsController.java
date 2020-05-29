package com.zy.controller;

import com.zy.service.StatisticsService;
import com.zy.vo.ResultVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
@ResponseBody
public class StatisticsController {

    @Resource
    StatisticsService statisticsService;

    @GetMapping("/statists/carlist")
    public ResultVo getCarList(@RequestParam("year") String year, @RequestParam("month") String month){
        System.out.println(year+month+"---");
        List<Double> carList = statisticsService.getCarListByYearMonth(year,month);
        System.out.println(carList.toString());
        return  ResultVo.success(carList);
    }

    @GetMapping("/statists/userList")
    public ResultVo getUserList(@RequestParam("year") String year, @RequestParam("userId") String userId){
        List<Double> carList = statisticsService.getUserByYearMonth(year,userId);
        System.out.println(carList.toString());
        return  ResultVo.success(carList);
    }

}
