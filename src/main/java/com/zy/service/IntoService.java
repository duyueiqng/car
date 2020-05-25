package com.zy.service;

import com.zy.pojo.Renttable;

/**
 * @author dyqstart
 * @create 2020-05-21 9:52
 */
public interface IntoService {
    /**
     * 通过输入的订单号查询租赁记录表中是否存在此订单
     * @param id
     * @return
     */
    Renttable findHave(Integer id);

    /**
     *
     */



}
