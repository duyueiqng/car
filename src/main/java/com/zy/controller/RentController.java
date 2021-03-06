package com.zy.controller;

import com.zy.pojo.Renttable;
import com.zy.service.RentService;
import com.zy.vo.PageResult;
import com.zy.vo.ResultVo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.UUID;

/**
 * @author dyqstart
 * @create 2020-05-18 10:56
 */
@RestController
@RequestMapping("/sys/rent")
public class RentController {

    @Resource
    private RentService rentService;


    //采用result风格(查询全部,条件查询和分页查询)
    @GetMapping("/page/{pageNo}/{pageSize}")
    @ResponseBody
    public ResultVo getByPage(@PathVariable Integer pageNo, @PathVariable Integer pageSize, Renttable renttable){
        System.out.println(renttable.getId());
        System.out.println("页码:"+pageNo+",页面容量:"+pageSize+",条件:"+renttable);
        PageResult pageResult = rentService.findAll(pageNo,pageSize,renttable);
        System.out.println("查询到的总条数:"+pageResult.getTotal());
        return ResultVo.success(pageResult);
    }
    //增加订单
    @PostMapping("/doAdd")
    @ResponseBody
    public ResultVo doAdd(@RequestBody Renttable renttable){
        System.out.println(renttable.toString());
        try {
            renttable.setId(UUID.randomUUID().toString());
            rentService.addRent(renttable);
            return ResultVo.success("添加新车辆成功!");
        }catch (Exception e){
            e.printStackTrace();
            return ResultVo.faile("添加新车辆失败!");
        }
    }

}
