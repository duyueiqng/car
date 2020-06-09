package com.zy.controller;

import com.zy.pojo.Book;
import com.zy.pojo.Car;
import com.zy.pojo.User;
import com.zy.service.BookService;
import com.zy.service.CarService;
import com.zy.service.UserService;
import com.zy.utils.MailUtils;
import com.zy.vo.BookVo;
import com.zy.vo.PageResult;
import com.zy.vo.ResultVo;
import com.zy.vo.UserVo;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.mail.MessagingException;
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

    @Resource
    UserService userService;

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

    @GetMapping("/page/{pageNo}/{pageSize}")
    public ResultVo pageList(@PathVariable Integer pageNo, @PathVariable Integer pageSize, BookVo bookVo){
        System.out.println("用户的页码:"+pageNo+",页面容量:"+pageSize+",条件:"+bookVo.toString());
        PageResult pageResult = bookService.findAll(pageNo,pageSize,bookVo);
        System.out.println("查询到的总条数:"+pageResult.getTotal());
        return ResultVo.success(pageResult);
    }
    @PostMapping("/updateBook")
    public ResultVo updateBook(@RequestBody Book book){
        System.out.println("是否通过"+book.getResult()+book.toString());
        String msg ="";
        try {
            if (book.getResult()==0){//通过
                bookService.updateBook(book);
                msg="通过成功，请联系客户";
            }else{
                bookService.updateBook(book);
                msg="驳回成功，请联系客户";
            }
            return ResultVo.success(msg);
        }catch (Exception e){
            return ResultVo.faile(msg);
        }

    }

    @GetMapping("/sendMail")
    public ResultVo sendMail(Book book){
        try{
            User user = userService.findByUsername(book.getCustId());
            if (book.getResult()==0){//通过
                //发送通过邮件
                String emailMsg = "恭喜您预订成功，请点击下面的连接进行通知店员"
                        + "<a href='http://127.0.0.1:8080/car/sys/book/active?id="+book.getId()+"&activeCode="+"已通知"+"'>"
                        + "浏览请点击"+"</a>";
                try {
                    MailUtils.sendMail(user.getEmail(), emailMsg);
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }else{//驳回
                String emailMsg = "很抱歉，预订失败，请点击下面的连接进行通知店员"
                        + "<a href='http://127.0.0.1:8080/car/sys/book/active?id="+book.getId()+"&activeCode="+"已通知"+"'>"
                        + "浏览请点击"+"</a>";
                try {
                    MailUtils.sendMail(user.getEmail(), emailMsg);
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
            }
            return ResultVo.faile("通知成功");
        }catch (Exception e){
            return ResultVo.faile("通知出现异常,请重试");
        }


    }

    @GetMapping("/active")
    public String success(String activeCode,Integer id){
            bookService.advise(activeCode,id);
            return "/index";

    }
}
