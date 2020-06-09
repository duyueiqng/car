package com.zy.service;

import com.zy.pojo.Activitiy;

import java.util.Date;
import java.util.List;

/**
 * @author dyqstart
 * @create 2020-06-09 11:17
 */
public interface ActivitiyService {

    /**
     * 根据时间对比查看为过期的活动
     */
    List<Activitiy> findListByTime(Date date);

    /**
     * 使数量减一
     */
    void updateByJian(Integer id);

    /**
     * 查询全部活动
     */
    List<Activitiy> findList();

    /**
     * 活动增加
     */
    void add(Activitiy activitiy);

}
