package com.zy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zy.mapper.RentMapper;
import com.zy.pojo.Renttable;
import com.zy.service.RentService;
import com.zy.vo.PageResult;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-18 9:06
 */
@Service
public class RentServiceImpl implements RentService {

    @Resource
    private RentMapper rentMapper;

    @Override
    public PageResult findAll(Integer pageNo, Integer pageSize, Renttable renttable) {
        LambdaQueryWrapper<Renttable> query=new LambdaQueryWrapper<>();
        //进行判断条件查询的条件是否为空
        query.eq(!StringUtils.isEmpty(renttable.getId()),Renttable::getId,renttable.getId())
                .eq(!StringUtils.isEmpty(renttable.getRentflag()),Renttable::getRentflag,renttable.getRentflag());


        //封装分页查询
        Page page = new Page(pageNo,pageSize);
        List<Renttable> list = rentMapper.findAll(page,query);

        return new PageResult(list,page.getTotal());
    }

    @Override
    public void updateRent(Renttable renttable) {
        rentMapper.updateById(renttable);
    }

    @Override
    public void addRent(Renttable renttable) {
        rentMapper.insert(renttable);
    }

    @Override
    public void deleteRent(Integer id) {

    }

    @Override
    public boolean getRentTableByCard(String idCard) {
        LambdaQueryWrapper<Renttable> query=new LambdaQueryWrapper<>();
        //进行判断条件查询的条件是否为空
        query.eq(!StringUtils.isEmpty(idCard),Renttable::getCustId,idCard)
            .eq(Renttable::getRentflag,1);
        Integer integer = rentMapper.selectCount(query);
        if (integer>0){
            return true;
        } else{
            return false;
        }
    }
}
