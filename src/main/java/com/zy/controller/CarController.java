package com.zy.controller;

import com.zy.pojo.Car;
import com.zy.service.CarService;
import com.zy.vo.CarVo;
import com.zy.vo.PageResult;
import com.zy.vo.ResultVo;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

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




}
