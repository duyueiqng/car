package com.zy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.zy.mapper.ActivitiyMapper;
import com.zy.pojo.Activitiy;
import com.zy.service.ActivitiyService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @author dyqstart
 * @create 2020-06-09 11:23
 */
@Service
public class ActivitiyServiceImpl implements ActivitiyService {

    @Resource
    private ActivitiyMapper activitiyMapper;

    @Override
    public List<Activitiy> findListByTime(Date date) {
        System.out.println(date.toString());
//        LambdaQueryWrapper queryWrapper = new LambdaQueryWrapper();
//        queryWrapper.ge(date.toString()!=null,"datetime",date);
        List<Activitiy> list = activitiyMapper.findAll(date);
        return list;
    }

    @Override
    public void updateByJian(Integer id) {
        activitiyMapper.updateById(id);
    }

    @Override
    public List<Activitiy> findList() {
        return activitiyMapper.selectList(null);
    }

    @Override
    public void add(Activitiy activitiy) {
        activitiyMapper.insert(activitiy);
    }
}
