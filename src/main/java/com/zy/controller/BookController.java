package com.zy.controller;

import com.zy.pojo.Book;
import com.zy.pojo.Car;
import com.zy.service.BookService;
import com.zy.service.CarService;
import com.zy.vo.ResultVo;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * @author shkstart
 * @date 2020/6/8 - 9:17
 */
@RestController
@RequestMapping("/sys/book")
public class BookController {
    @Resource
    BookService bookService;

    @Resource
    CarService carService;

    //添加预订
    @PostMapping("/doAdd")
    public ResultVo doAdd(@RequestBody Book book){
        System.out.println("请求预订的车俩:"+book.getCarId());
        String msg = "添加预订失败!";
        try {
            //修改车辆状态
            carService.updateStatus(book.getCarId());

            //添加预订单
            LocalDateTime time = book.getDate();
            LocalDateTime of = LocalDateTime.of(time.getYear(), time.getMonth(), time.getDayOfMonth() + 1, time.getHour(), time.getMinute());
            book.setEndTime(of);
            book.setFlag(1);
            bookService.doAdd(book);
            msg="添加预订成功!";
            return ResultVo.success(msg);
        }catch (Exception e){
            e.printStackTrace();
            return ResultVo.faile(msg);
        }

    }
}
