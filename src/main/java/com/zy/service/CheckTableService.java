package com.zy.service;

import com.zy.pojo.Checktable;

/**
 * @author dyqstart
 * @create 2020-05-23 10:07
 */
public interface CheckTableService {

    /**
     * 根据订单号查询相应的违规信息
     */
    Checktable findByRent(Integer rentId);



}
