package com.zy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.zy.mapper.UserMapper;
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
        List<User> list = baseMapper.findAll(page,query);

        return new PageResult(list,page.getTotal());
    }

    @Override
    public void doAdd(User user) {
        baseMapper.insert(user);
    }

    @Override
    public void doUpdate(User user) {
        baseMapper.updateById(user);
    }

    @Override
    public void del(Integer id) {
        baseMapper.deleteById(id);
    }

    @Override
    public User findByUsername(String username) {
        LambdaQueryWrapper<User> wrapper = Wrappers.<User>lambdaQuery();
        wrapper.eq(User::getUsercode,username);
        return super.getOne(wrapper);
    }
    @Override
    public User findByCard(User user) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(User::getIdCard,user.getIdCard());
        return baseMapper.selectOne(queryWrapper);
    }
    @Override
    public User getUserByCard(String idCard) {
        LambdaQueryWrapper<User> wrapper = Wrappers.<User>lambdaQuery();
        wrapper.eq(User::getIdCard,idCard);
        return super.getOne(wrapper);
    }

    @Override
    public boolean register(User user) {
        int row = baseMapper.insert(user);
        if (row>0){
            return true;
        }else{
            return false;
        }
    }

    @Override
    public void active(String activeCode) {

        baseMapper.updateUser(activeCode);
    }

    @Override
    public boolean getUserByUserCode(String usercode) {
        LambdaQueryWrapper<User> wrapper = Wrappers.<User>lambdaQuery();
        wrapper.eq(User::getUsercode,usercode);
        User user = baseMapper.selectOne(wrapper);
        if (user!=null){
            return false;//不能注册
        }else{
            return true;//可以注册
        }
    }

    @Override
    public void updatePwd(String pwdNew, Integer userid) {
        baseMapper.updateUserPwd(pwdNew,userid);
    }
}
