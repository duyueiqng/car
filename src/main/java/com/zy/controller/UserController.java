package com.zy.controller;

import com.zy.pojo.User;
import com.zy.service.UserService;
import com.zy.vo.PageResult;
import com.zy.vo.ResultVo;
import com.zy.vo.UserVo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * @author dyqstart
 * @create 2020-05-11 10:07
 */
@RestController
@RequestMapping("/sys/user")
public class UserController {

    @Resource
    private UserService userService;



    @GetMapping("/page/{pageNo}/{pageSize}")
    public ResultVo pageList(@PathVariable Integer pageNo, @PathVariable Integer pageSize, UserVo userVo){
        System.out.println(userVo.getUsername());
        System.out.println("用户的页码:"+pageNo+",页面容量:"+pageSize+",条件:"+userVo);
        PageResult pageResult = userService.findAll(pageNo,pageSize,userVo);
        System.out.println("查询到的总条数:"+pageResult.getTotal());
        return ResultVo.success(pageResult);
    }


    //添加新用户
    @PostMapping("/doAdd")
    public ResultVo doAdd(@RequestBody User user){
        System.out.println("请求添加的客户:"+user.getBirthday());
        String msg = "添加新客户失败!";
        try {
            msg="添加新客户成功!";
            userService.doAdd(user);
            return ResultVo.success(msg);
        }catch (Exception e){
            return ResultVo.success(msg);
        }

    }

    //修改用户
    @PostMapping("/doUpdate")
    public ResultVo doUpdate(@RequestBody User user){
        System.out.println("请求修改的客户:"+user.getUsername());
        String msg = "修改客户信息失败!";
        try {
            msg="修改客户信息成功!";
            userService.doUpdate(user);
            return ResultVo.success(msg);
        }catch (Exception e){
            return ResultVo.success(msg);
        }

    }


    //删除用户
    @RequestMapping("/del")
    public String del(Integer id){
        System.out.println("进入删除操作!id:"+id);
        String msg = "删除客户失败!";
        try {
            userService.del(id);
            msg = "删除客户成功!";
            return msg;
        }catch (Exception e){
            return msg;
        }
    }





}
