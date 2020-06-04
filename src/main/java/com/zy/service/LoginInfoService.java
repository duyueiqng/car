package com.zy.service;

import com.zy.pojo.Loginfo;
import com.zy.vo.LogInfoVo;

import java.util.List;

/**
 * @author Mxb
 * @version 1.0
 * @date 2019/11/1 9:11
 * 登录日志接口
 */
public interface LoginInfoService {

    //查询所有日志
    public List<Loginfo> queryAllLoginInfo(LogInfoVo logInfoVo);

    //添加日志
    public void addLog(LogInfoVo logInfoVo);

    //删除日志
    public void deleteLogInfo(Integer id);

    //批量删除日志
    public void deleteBatchLog(Integer[] ids);

}
