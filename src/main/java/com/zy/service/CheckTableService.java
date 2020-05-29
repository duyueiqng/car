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

    /**
     * 增加检查表
     * @param checked
     */
    void addChecked(Checktable checked);

    /**
     * 修改检查表
     * @param checktable
     */
    void updateChecked(Checktable checktable);

    /**
     * 删除检查表通过Id
     * @param checkedId
     */
    void deleteCheckedById(Integer checkedId);
}
