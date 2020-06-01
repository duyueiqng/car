package com.zy.controller;

import com.zy.pojo.Car;
import com.zy.service.CarService;
import com.zy.vo.CarVo;
import com.zy.vo.PageResult;
import com.zy.vo.ResultVo;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @author dyqstart
 * @create 2020-05-07 16:13
 */
@RestController
@RequestMapping("/sys/car")
public class CarController {
    @Resource
    private CarService carService;

    @GetMapping("/list")
    public List<Car> list(){
        List<Car> list = carService.selectByList();
        return list;
    }

    //采用result风格(查询全部,条件查询和分页查询)
    @GetMapping("/page/{pageNo}/{pageSize}")
    @ResponseBody
    public ResultVo getByPage(@PathVariable Integer pageNo, @PathVariable Integer pageSize,CarVo carVo){
        System.out.println(carVo.getCarColor());
        System.out.println("页码:"+pageNo+",页面容量:"+pageSize+",条件:"+carVo);
        PageResult pageResult = carService.findAll(pageNo,pageSize,carVo);
        System.out.println("查询到的总条数:"+pageResult.getTotal());
        return ResultVo.success(pageResult);
    }

    //添加新车辆
    @PostMapping("/doAdd")
    public ResultVo doAdd(@RequestBody Car car){
        System.out.println("请求添加的车俩:"+car.getCarNumber());
        String msg = "添加新车辆失败!";
        try {
            msg="添加新车辆成功!";
            carService.doAdd(car);
            return ResultVo.success(msg);
        }catch (Exception e){
            return ResultVo.success(msg);
        }

    }

    //修改车辆信息
    @PostMapping("/doUpdate")
    public ResultVo doUpdate(@RequestBody Car car){
        System.out.println("请求修改的车俩:"+car.getCarNumber());
        String msg = "修改车辆失败!";
        try {
            msg="修改车辆成功!";
            carService.doUpdate(car);
            return ResultVo.success(msg);
        }catch (Exception e){
            return ResultVo.success(msg);
        }

    }


    //删除车辆信息
    @RequestMapping("/del")
    public String del(Integer id){
        System.out.println("进入删除操作!id:"+id);
        String msg = "删除好友失败!";
        try {
            carService.del(id);
            msg = "删除好友成功!";
            return msg;
        }catch (Exception e){
            return msg;
        }
    }


    //文件上传功能
    @PostMapping("/upload")
    @ResponseBody
    public ResultVo upload(MultipartFile carImg, HttpServletRequest request){
        ServletContext sc=request.getServletContext();//sc相当于jsp中的内置对象application
        String realPath=sc.getRealPath("/attach");//应用程序的根目录下的attach文件夹对应绝对路径
        File folder=new File(realPath);
        if(folder.exists()==false){  //判断attach目录是否存在，不存在会自动创建
            folder.mkdirs();
        }
        String original=carImg.getOriginalFilename(); //得到上传的原始文件名
        System.out.println("原始的文件名:"+original);
        int index=original.lastIndexOf(".");
        String suffix=original.substring(index); //得到后缀名
        String newFileName= UUID.randomUUID().toString()+suffix; //为上传文件起一个新的唯一的文件名
        File file=new File(folder,newFileName);
        try {
            carImg.transferTo(file); //执行上传
        } catch (IOException e) {
            e.printStackTrace();
        }
        Map<String,Object> map=new HashMap<>();
        map.put("carImg","attach/"+newFileName);
        System.out.println("最后返回的map:"+map);
        return ResultVo.success(map);
    }




}
