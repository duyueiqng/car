package com.zy.service;

import com.zy.pojo.Car;

import java.util.List;

/**
 * @author shkstart
 * @date 2020/5/25 - 10:49
 */
public interface StatisticsService {
    List<Double> getCarListByYearMonth(String year, String month);
}
