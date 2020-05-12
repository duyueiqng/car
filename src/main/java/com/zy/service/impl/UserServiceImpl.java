package com.zy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zy.mapper.UserMapper;
import com.zy.pojo.Car;
import com.zy.pojo.User;
import com.zy.service.UserService;
import com.zy.vo.PageResult;
import com.zy.vo.UserVo;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-11 8:50
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper,User> implements UserService {

    @Resource
    private UserMapper userMapper;

    @Override
    public List<User> selectByList() {
        return null;
    }

    @Override
    public PageResult findAll(Integer pageNo, Integer pageSize, UserVo userVo) {
        LambdaQueryWrapper<User> query=new LambdaQueryWrapper<>();

        query.like(!StringUtils.isEmpty(userVo.getUsername()),User::getUsername,userVo.getUsername())
                .eq(!StringUtils.isEmpty(userVo.getUser_role()),User::getUserRole,userVo.getUser_role())
                .eq(!StringUtils.isEmpty(userVo.getId_card()),User::getIdCard,userVo.getId_card());

        //封装分页查询
        Page page = new Page(pageNo,pageSize);
        List<User> list = userMapper.findAll(page,query);

        return new PageResult(list,page.getTotal());
    }

    @Override
    public void doAdd(User user) {
        userMapper.insert(user);
    }

    @Override
    public void doUpdate(User user) {
        userMapper.updateById(user);
    }

    @Override
    public void del(Integer id) {
        userMapper.deleteById(id);
    }

    @Override
    public User findByUsername(String username) {
        LambdaQueryWrapper<User> wrapper = Wrappers.<User>lambdaQuery();
        wrapper.eq(User::getUsercode,username);
        return super.getOne(wrapper);
    }
}
