package com.zy.controller;

import com.zy.pojo.Checktable;
import com.zy.service.CheckTableService;
import com.zy.vo.CheckedVo;
import com.zy.vo.ResultVo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

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
        String id = checktable.getRentId();
        System.out.println("要查询的订单号码(违规):"+id);
        Checktable checktable1 = checkTableService.findByRent(id);
        System.out.println(checktable1);
        return ResultVo.success(checktable1);
    }

    @GetMapping("/searchCheckedList")
    public ResultVo searchCheckedList(CheckedVo checkedVo){
        List<Checktable> checktableList = checkTableService.findCheckByCondition(checkedVo);
        System.out.println(checktableList.toString());
        return ResultVo.success(checktableList);
    }

    @PostMapping("/updateChecked")
    public ResultVo updateChecked(@RequestBody Checktable checktable){
        String msg = "修改检查表失败!";
        try{
            msg="修改检查表成功!";
            System.out.println(checktable.toString());
            checkTableService.updateChecked(checktable);
            return ResultVo.success(msg);
        }catch (Exception e){
            return ResultVo.success(msg);
        }
    }
    @PostMapping("/addChecked")
    public ResultVo addChecked(@RequestBody Checktable checktable){
        String msg = "增加检查表失败!";
        try{
            msg="增加检查表成功!";
            System.out.println(checktable.toString());
            checkTableService.addChecked(checktable);
            return ResultVo.success(msg);
        }catch (Exception e){
            return ResultVo.success(msg);
        }
    }

    @GetMapping("/del")
    public ResultVo delChecked(Integer checkedId){
        String msg = "删除检查表失败!";
        try{
            msg="删除检查表成功!";
            System.out.println(checkedId+"----");
            checkTableService.deleteCheckedById(checkedId);
            return ResultVo.success(msg);
        }catch (Exception e){
            return ResultVo.success(msg);
        }
    }

}
