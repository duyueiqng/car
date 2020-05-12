package com.zy.service;

import com.zy.pojo.User;
import com.zy.vo.PageResult;
import com.zy.vo.UserVo;

import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-11 8:37
 */
public interface UserService {

    /**
     * 基础便利
     * @return
     */

    List<User> selectByList();

    /**
     * 分页便利返回一个自定义的分页的对象
     * @param pageNo
     * @param pageSize
     * @param
     * @return
     */
    PageResult findAll(Integer pageNo, Integer pageSize, UserVo userVo);

    /**
     * 添加
     */
    void doAdd(User user);

    /**
     * 修改
     */
    void doUpdate(User user);

    /**
     * 删除
     */
    void del(Integer id);

}
