package com.zy.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zy.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-11 8:35
 */
public interface UserMapper extends BaseMapper<User> {

    //查询全部或条件查询(ew代表携带条件)page为分页
    List<User> findAll(Page page, @Param("ew") Wrapper wrapper);

    //修改用户状态
    @Update("update user set state = 1 where code = #{activeCode}")
    void updateUser(String activeCode);

    //修改密码
    @Update("update user set password = #{pwdNew} where id = #{userid}")
    void updateUserPwd(@Param("pwdNew") String pwdNew,@Param("userid") Integer userid);
}
