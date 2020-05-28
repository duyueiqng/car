package com.zy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.zy.mapper.CheckTableMapper;
import com.zy.pojo.Checktable;
import com.zy.service.CheckTableService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author dyqstart
 * @create 2020-05-23 10:10
 */
@Service
public class CheckTableServiceImpl implements CheckTableService {

    @Resource
    private CheckTableMapper checkTableMapper;


    @Override
    public Checktable findByRent(String rentId) {
        LambdaQueryWrapper<Checktable> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Checktable::getRentId,rentId);
        return checkTableMapper.selectOne(queryWrapper);
    }
}
