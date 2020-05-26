package com.zy.controller;

import com.zy.pojo.Car;
import com.zy.service.StatisticsService;
import com.zy.vo.ResultVo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@ResponseBody
public class StatisticsController {

    @Resource
    StatisticsService statisticsService;

    @GetMapping("/statists/carlist")
    public ResultVo getCarList(@RequestParam("year") String year, @RequestParam("month") String month, HttpServletRequest request){
        System.out.println(year+month+"---");
        List<Car> carList = statisticsService.getCarListByYearMonth(year,month);
        System.out.println(carList.toString());
        request.setAttribute("year",year);
        return  ResultVo.success(carList);
    }

}
