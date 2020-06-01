package com.zy.controller;

import com.zy.pojo.Loginfo;
import com.zy.service.LoginInfoService;
import com.zy.vo.LogInfoVo;
import com.zy.vo.ResultVo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author Mxb
 * @version 1.0
 * @date 2019/11/1 9:23
 * 日志管理控制器类
 */
@RestController
@RequestMapping("/sys/logInfo")
public class LogInfoController {

    @Resource
    private LoginInfoService loginInfoService;

    //加载所有日志
    @GetMapping("/getAll")
    @ResponseBody
    public ResultVo loadAllLogInfo(LogInfoVo logInfoVo) {
        System.out.println("logInfoVo----"+logInfoVo.toString());
        List<Loginfo> logInfo = this.loginInfoService.queryAllLoginInfo(logInfoVo);
//        System.out.println(logInfo.toString());
        return ResultVo.success(logInfo);
    }

    //删除日志
    @GetMapping("/deleteLog")
    public ResultVo deleteLog(Integer id) {
        try {
            this.loginInfoService.deleteLogInfo(id);
            return ResultVo.success("删除成功！");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultVo.success("删除错误！");
        }
    }

    //批量删除
    @GetMapping("/deleteBatchLog")
    public ResultVo deleteBatchLog(Integer[] ids) {
        try {
            this.loginInfoService.deleteBatchLog(ids);
            return ResultVo.success("删除成功！");
        } catch (Exception e) {
            e.printStackTrace();
            return ResultVo.success("删除错误！");
        }
    }
}
