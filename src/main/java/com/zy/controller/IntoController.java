package com.zy.controller;

import com.zy.pojo.Car;
import com.zy.pojo.Renttable;
import com.zy.pojo.User;
import com.zy.service.CarService;
import com.zy.service.IntoService;
import com.zy.service.RentService;
import com.zy.service.UserService;
import com.zy.vo.CarVo;
import com.zy.vo.ResultVo;
import com.zy.vo.ReturnVo;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-21 9:59
 */
@RestController
@RequestMapping("/sys/rent")
public class IntoController {
    @Resource
    private IntoService intoService;
    @Resource
    private CarService carService;
    @Resource
    private UserService userService;
    @Resource
    private RentService rentService;


    @GetMapping("/select")
    public ResultVo findok(Renttable renttable){
        String msg = "系统错误!";
        String id = renttable.getId();
        Renttable renttable1 = intoService.findHave(id);
        if (renttable1==null){
            msg="暂无此订单,请核对后重试!";
        }else if(renttable1.getRentflag()==0){
            msg="此订单交易已完成,谢谢您的使用!";
        }else{
            List<Renttable> list = new ArrayList<>();
            list.add(renttable1);
            System.out.println(list);
            return ResultVo.success(list);
        }
        System.out.println(msg);
        return ResultVo.success(msg);

    }

    //归还车辆查询
    @GetMapping("/car")
    public ResultVo car(Car car){
        String num = car.getCarNumber();
        CarVo carVo = new CarVo();
        carVo.setCarNumber(num);
        Car car1 = carService.findBynum(num);
        System.out.println(car1);
        return ResultVo.success(car1);

    }



    //归还客户查询
    @GetMapping("/user")
    public ResultVo user(User user){
        String num = user.getIdCard();
        User user1 = user1= userService.findByCard(user);
        System.out.println(user1);
        return ResultVo.success(user1);

    }

    //归还
    @GetMapping("/todoupdate")
    public ResultVo doReturn(ReturnVo returnVo){
        String msg="归还成功!";
        System.out.println("归还接收:"+returnVo);
        Renttable renttable = new Renttable();
        renttable.setId(returnVo.getRentId());
        renttable.setRentflag(0);
        Car car = new Car();
        car.setIsFree(0);
        car.setId(returnVo.getCarid());
        try {
            rentService.updateRent(renttable);
            carService.doUpdate(car);
        }catch (Exception e){
            msg="归还失败!";
        }
        return ResultVo.success(msg);

    }




}
