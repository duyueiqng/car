package com.zy.controller;

import com.zy.pojo.User;
import com.zy.service.UserService;
import com.zy.utils.MailUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.UUID;

/**
 * @author shkstart
 * @date 2020/6/3 - 10:01
 */
@Controller
@RequestMapping("/sys/register")
public class RegisterController {
    @Resource
    UserService userService;

    //注册
    @PostMapping("/registAdd")
    @ResponseBody
    public String register(@RequestBody User user,HttpSession session,Model model){
        System.out.println("请求添加的客户:"+user.getBirthday());
        try {
            //获得存储在session中的验证码
            String regMag="";
            String sessionCheckCode = (String) session.getAttribute("code");
            //判断验证码是否正确
            if (user.getCode()==null || !sessionCheckCode.equals(user.getCode())){
                //登陆失败，提示验证码不正确！
                regMag ="验证码错误！";
                model.addAttribute("regMag",regMag);
                return "";
            }
            if (user.getCreatedate()==null){
                user.setCreatedate(LocalDateTime.now());
            }
            if(user.getUserRole()==null){
                user.setUserRole(5);
            }
            user.setSalt("qwert");
            //private String code;//激活码
            String activeCode = UUID.randomUUID().toString();
            user.setCode(activeCode);
            boolean flag = userService.register(user);
            if (flag){
                //发送激活邮件
                String emailMsg = "恭喜您注册成功，请点击下面的连接进行激活账户"
                        + "<a href='http://localhost:8080/car/sys/register/active?activeCode="+activeCode+"'>"
                        + "http://localhost:8080/car/sys/register/active?activeCode="+activeCode+"</a>";
                try {
                    MailUtils.sendMail(user.getEmail(), emailMsg);
                } catch (MessagingException e) {
                    e.printStackTrace();
                }
                return "true";
            }else{
                return "redirect:/registerFail";
            }
        }catch (Exception e){
            return "false";
        }

    }
    @GetMapping("/registerFail")
    public String faile(){
        return "sys/register/registerFail";
    }
    @GetMapping("/success")
    public String success(){
        return "/sys/register/registerSuccess";
    }

    @GetMapping("/active")
    public String success(String activeCode){
        userService.active(activeCode);
        System.out.println("验证通过了");
        return "redirect:/index";
    }
    @GetMapping("/volidateUserCode")
    @ResponseBody
    public Boolean getUserByUserCode(String usercode){
        boolean flag = userService.getUserByUserCode(usercode);
        System.out.println(flag);
        return flag;
    }
}
