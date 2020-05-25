package com.zy.controller;

import com.zy.pojo.Checktable;
import com.zy.service.CheckTableService;
import com.zy.vo.ResultVo;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * @author dyqstart
 * @create 2020-05-23 10:00
 */
@RestController
@RequestMapping("/sys/checktable")
public class CheckController {


    @Resource
    private CheckTableService checkTableService;

    @GetMapping("/select")
    public ResultVo select(Checktable checktable){
        Integer id = checktable.getRentId();
        System.out.println("要查询的订单号码(违规):"+id);
        Checktable checktable1 = checkTableService.findByRent(id);
        System.out.println(checktable1);
        return ResultVo.success(checktable1);



    }



}
