package com.zy.controller;

import com.zy.pojo.Activitiy;
import com.zy.service.ActivitiyService;
import com.zy.vo.ResultVo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * @author dyqstart
 * @create 2020-06-09 11:27
 */
@RestController
@RequestMapping("/sys/activitiy")
public class ActivitiyController {

    @Resource
    private ActivitiyService activitiyService;

    @GetMapping("/list")
    public ResultVo test(){
        List<Activitiy> list = activitiyService.findListByTime(new Date());
        System.out.println(list.toArray());


        return ResultVo.success(list);

    }

    @GetMapping("/find")
    public ResultVo find(){
        List<Activitiy> list = activitiyService.findList();
        return ResultVo.success(list);
    }

    @PostMapping("/doAdd")
    public ResultVo test(@RequestBody Activitiy activitiy){
        System.out.println(activitiy.toString());
        String msg="活动添加失败!";
        try {
            activitiyService.add(activitiy);
            msg="活动添加成功!";
            return ResultVo.success(msg);
        }catch (Exception e){
            System.out.println(e);
            return ResultVo.success(msg);
        }

    }






}
