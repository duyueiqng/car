package com.zy.service.impl;

import com.zy.mapper.StstistscsMapper;
import com.zy.pojo.Car;
import com.zy.service.StatisticsService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author shkstart
 * @date 2020/5/25 - 10:51
 */
@Service
public class StaticsServiceImpl implements StatisticsService {
    @Resource
    StstistscsMapper ststistscsMapper;

    @Override
    public List<Double> getCarListByYearMonth(String year, String month) {
        return ststistscsMapper.getCarListByYearMonth(year,month);
    }

    @Override
    public List<Double> getUserByYearMonth(String year, String userId) {
        return ststistscsMapper.getUserByYearMonth(year,userId);
    }
}
