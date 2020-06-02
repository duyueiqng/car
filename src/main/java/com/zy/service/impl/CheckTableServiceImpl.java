package com.zy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.zy.mapper.CheckTableMapper;
import com.zy.pojo.Checktable;
import com.zy.service.CheckTableService;
import com.zy.vo.CheckedVo;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.List;

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

    @Override
    public List<Checktable> findCheckByCondition(CheckedVo checkedVo) {
        LambdaQueryWrapper<Checktable> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(checkedVo.getCheckId()!=null,Checktable::getRentId,checkedVo.getCheckId())
            .eq(checkedVo.getRentId()!=null,Checktable::getRentId,checkedVo.getRentId())
            .like(!StringUtils.isEmpty(checkedVo.getProblem()),Checktable::getProblem,checkedVo.getProblem())
            .ge(checkedVo.getStartTime()!=null,Checktable::getCheckDate,checkedVo.getStartTime())
            .le(checkedVo.getEndTime()!=null,Checktable::getCheckDate,checkedVo.getEndTime());
        return checkTableMapper.selectList(queryWrapper);
    }

    @Override
    public void addChecked(Checktable checked) {
        checkTableMapper.insert(checked);
    }

    @Override
    public void updateChecked(Checktable checktable) {
        System.out.println(checktable.toString());
        LambdaQueryWrapper<Checktable> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(checktable.getCheckId()!=null,Checktable::getCheckId,checktable.getCheckId());
        checkTableMapper.update(checktable,queryWrapper);
    }

    @Override
    public void deleteCheckedById(Integer checkedId) {
        LambdaQueryWrapper<Checktable> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(checkedId!=null,Checktable::getCheckId,checkedId);
        checkTableMapper.delete(queryWrapper);
    }
}
