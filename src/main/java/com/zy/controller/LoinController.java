package com.zy.controller;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoinController {
    @GetMapping({"/login","/"})
    public String toLogin(){
        return "login";
    }
    @PostMapping("/login")
    public String login(String username,String password){
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(username,password);
        subject.login(token);
        return "redirect:/index";
    }

    @ExceptionHandler({RuntimeException.class})
    public String handleException(RuntimeException e, Model model){
        String loginErr = "";
        e.printStackTrace();
        if (e instanceof UnknownAccountException){
            loginErr="用户名或者密码错误";
        }else if (e instanceof IncorrectCredentialsException){
            loginErr="用户名或者密码错误";
        }else {
            loginErr="系统错误，请联系管理员";
        }
        model.addAttribute("loginErr",loginErr);
        return "login";
    }
}
