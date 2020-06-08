package com.zy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zy.mapper.CarMapper;
import com.zy.pojo.Car;
import com.zy.service.CarService;
import com.zy.vo.CarVo;
import com.zy.vo.PageResult;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

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

    @Override
    public PageResult findAll(Integer pageNo, Integer pageSize, CarVo carVo) {
        LambdaQueryWrapper<Car> query=new LambdaQueryWrapper<>();

//        query.like(!StringUtils.isEmpty(userVo.getUserCode()),User::getUserCode,userVo.getUserCode())
//                .eq(userVo.getUserRole()!=null,User::getUserRole,userVo.getUserRole())
//                .ge(userVo.getStartDate()!=null,User::getBirthday,userVo.getStartDate())
//                .le(userVo.getEndDate()!=null,User::getBirthday,userVo.getEndDate());

        //进行判断条件查询的条件是否为空
        query.like(!StringUtils.isEmpty(carVo.getCarNumber()),Car::getCarNumber,carVo.getCarNumber())
                .like(!StringUtils.isEmpty(carVo.getCarColor()),Car::getCarColor,carVo.getCarColor())
                .like(!StringUtils.isEmpty(carVo.getCarType()),Car::getCarType,carVo.getCarType());

        //封装分页查询
        Page page = new Page(pageNo,pageSize);
        List<Car> list = carMapper.findAll(page,query);

        return new PageResult(list,page.getTotal());

    }

    /**
     * 添加
     * @param car
     */
    @Override
    public void doAdd(Car car) {
        int insert = carMapper.insert(car);
        System.out.println("insert车辆---"+insert);
    }

    /**
     * 修改
     * @param car
     */
    @Override
    public void doUpdate(Car car) {
        carMapper.updateById(car);
    }

    @Override
    public void del(Integer id) {
        carMapper.deleteById(id);
    }

    @Override
    public Car findBynum(String carNumber) {
        LambdaQueryWrapper<Car> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Car::getCarNumber,carNumber);
        return carMapper.selectOne(queryWrapper);
    }

    @Override
    public List<Car> selectByListByFree(String isFree) {
        LambdaQueryWrapper<Car> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Car::getIsFree,isFree);
        return carMapper.selectList(queryWrapper);
    }

    @Override
    public void updateStatus(String carId) {
        LambdaQueryWrapper<Car> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Car::getCarNumber,carId);
        Car car = carMapper.selectOne(queryWrapper);
        car.setCarNumber(carId);
        car.setIsFree(1);
        carMapper.updateById(car);
    }
}
