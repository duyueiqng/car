package com.zy.controller;

import com.zy.pojo.User;
import com.zy.service.UserService;
import com.zy.utils.MailUtils;
import com.zy.vo.PageResult;
import com.zy.vo.ResultVo;
import com.zy.vo.UserVo;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * @author dyqstart
 * @create 2020-05-11 10:07
 */
@RestController
@RequestMapping("/sys/user")
public class UserController extends BaseController{

    @Resource
    private UserService userService;

    @GetMapping("/getUserByCard")
    public ResultVo getUserByCard(String idCard){
        User user = userService.getUserByCard(idCard);
        return ResultVo.success(user);
    }

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
            if (user.getCreatedate()==null){
                user.setCreatedate(LocalDateTime.now());
            }
            if(user.getUserRole()==null){
                user.setUserRole(5);
            }
            user.setSalt("qwert");
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


    //文件上传功能
    @PostMapping("/upload")
    @ResponseBody
    public ResultVo upload(MultipartFile attachPath, HttpServletRequest request){
        ServletContext sc=request.getServletContext();//sc相当于jsp中的内置对象application
        String realPath=sc.getRealPath("/attach");//应用程序的根目录下的attach文件夹对应绝对路径
        File folder=new File(realPath);
        if(folder.exists()==false){  //判断attach目录是否存在，不存在会自动创建
            folder.mkdirs();
        }
        String original=attachPath.getOriginalFilename(); //得到上传的原始文件名
        System.out.println("上传的原始的文件名:"+original);
        int index=original.lastIndexOf(".");
        String suffix=original.substring(index); //得到后缀名
        String newFileName= UUID.randomUUID().toString()+suffix; //为上传文件起一个新的唯一的文件名
        File file=new File(folder,newFileName);
        try {
            attachPath.transferTo(file); //执行上传
        } catch (IOException e) {
            e.printStackTrace();
        }
        Map<String,Object> map=new HashMap<>();
        map.put("attachPath","attach/"+newFileName);
        System.out.println("user最后返回的map:"+map);
        return ResultVo.success(map);
    }







}
