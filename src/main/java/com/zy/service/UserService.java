package com.zy.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.zy.pojo.User;
import com.zy.vo.PageResult;
import com.zy.vo.UserVo;

import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-11 8:37
 */
public interface UserService extends IService<User> {

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

    /**
     * 通过用户名查找用户
     * @param username
     * @return
     */
    User findByUsername(String username);

    /**
     * 归还的user的查询
     */
    User findByCard(User user);

    /**
     * 通过身份证得到用户
     * @param idCard
     * @return
     */
    public User getUserByCard(String idCard);
}
