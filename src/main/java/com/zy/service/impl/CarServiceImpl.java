package com.zy.service.impl;

import com.zy.mapper.CarMapper;
import com.zy.pojo.Car;
import com.zy.service.CarService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-07 16:11
 */
@Service
public class CarServiceImpl implements CarService {
    @Resource
    private CarMapper carMapper;


    @Override
    public List<Car> selectByList() {
        return carMapper.selectByList();
    }
}
