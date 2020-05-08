package com.zy.controller;

import com.zy.pojo.Car;
import com.zy.service.CarService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-07 16:13
 */
@RestController
@RequestMapping("/sys/car")
public class CarController {
    @Resource
    private CarService carService;

    @GetMapping("/list")
    public List<Car> list(){

        List<Car> list = carService.selectByList();
        return list;
    }

}
