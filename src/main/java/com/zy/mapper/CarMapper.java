package com.zy.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zy.pojo.Car;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-07 16:03
 */
public interface CarMapper extends BaseMapper<Car> {

    List<Car> selectByList();

    //查询全部或条件查询(ew代表携带条件)page为分页
    List<Car> findAll(Page page, @Param("ew") Wrapper wrapper);

}
