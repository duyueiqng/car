package com.zy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.zy.mapper.LogInfoMapper;
import com.zy.pojo.Loginfo;
import com.zy.service.LoginInfoService;
import com.zy.vo.LogInfoVo;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author Mxb
 * @version 1.0
 * @date 2019/11/1 9:18
 */
@Service
public class LoginInfoServiceImpl implements LoginInfoService {

    @Resource
    private LogInfoMapper logInfoMapper;

    @Override
    public List<Loginfo> queryAllLoginInfo(LogInfoVo logInfoVo) {
//        Page<Object> page = PageHelper.startPage(logInfoVo.getPage(), logInfoVo.getLimit());
        LambdaQueryWrapper<Loginfo> query = Wrappers.<Loginfo>lambdaQuery();
        query.eq(!StringUtils.isEmpty(logInfoVo.getLoginname()),Loginfo::getLoginname,logInfoVo.getLoginname())
                .eq(!StringUtils.isEmpty(logInfoVo.getLoginip()),Loginfo::getLoginip,logInfoVo.getLoginip())
                .ge(!StringUtils.isEmpty(logInfoVo.getStartTime()),Loginfo::getLogintime,logInfoVo.getStartTime())
                .le(!StringUtils.isEmpty(logInfoVo.getEndTime()),Loginfo::getLogintime,logInfoVo.getEndTime());
        List<Loginfo> data = this.logInfoMapper.selectList(query);

        return data;
    }

    @Override
    public void addLog(LogInfoVo logInfoVo) {
        this.logInfoMapper.insert(logInfoVo);
    }

    @Override
    public void deleteLogInfo(Integer id) {
        this.logInfoMapper.deleteById(id);
    }

    @Override
    public void deleteBatchLog(Integer[] ids) {
//        System.out.println(ids.toString());
        for (Integer id : ids) {
            this.logInfoMapper.deleteById(id);
        }
    }
}
