package com.zy.service.impl;

import com.zy.mapper.RentMapper;
import com.zy.pojo.Renttable;
import com.zy.service.IntoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author dyqstart
 * @create 2020-05-21 9:56
 */
@Service
public class IntoServiceImpl implements IntoService {
    @Resource
    private RentMapper rentMapper;



    @Override
    public Renttable findHave(Integer id) {
        return rentMapper.selectById(id);
    }
}
