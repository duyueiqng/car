package com.zy.service;

import com.zy.pojo.Checktable;
import com.zy.vo.CheckedVo;

import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-23 10:07
 */
public interface CheckTableService {

    /**
     * 根据订单号查询相应的违规信息
     */
    Checktable findByRent(String rentId);

    /**
     * 根据条件查询检查表
     * @param checkedVo
     * @return
     */
    List<Checktable> findCheckByCondition(CheckedVo checkedVo);
}
