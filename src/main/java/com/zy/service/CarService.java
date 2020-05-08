package com.zy.service;

import com.zy.pojo.Car;
import com.zy.vo.CarVo;
import com.zy.vo.PageResult;

import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-07 16:09
 */
public interface CarService {

    /**
     * 基础便利
     * @return
     */

    List<Car> selectByList();

    /**
     * 分页便利返回一个自定义的分页的对象
     * @param pageNo
     * @param pageSize
     * @param carVo
     * @return
     */
    PageResult findAll(Integer pageNo, Integer pageSize, CarVo carVo);

    /**
     * 添加
     */
    void doAdd(Car car);

    /**
     * 修改
     */
    void doUpdate(Car car);

    /**
     * 删除
     */
    void del(Integer id);
}
