package com.zy.service;

import com.zy.pojo.Renttable;
import com.zy.vo.PageResult;


/**
 * @author dyqstart
 * @create 2020-05-18 9:05
 */
public interface RentService {

    /**
     * 便利所有的订单
     * (条件查询根据订单编号和出租状态查询)
     */
    PageResult findAll(Integer pageNo, Integer pageSize, Renttable renttable);

    /**
     * 修改订单
     */
    void updateRent(Renttable renttable);

    /**
     * 添加订单
     */
    void addRent(Renttable renttable);

    /**
     * 删除订单
     */
    void deleteRent(Integer id);

    /**
     * 查找用户是否有未完成的订单
     * @param idCard
     * @return
     */
    boolean getRentTableByCard(String idCard);
}
