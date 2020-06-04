package com.zy.controller;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import com.zy.service.LoginInfoService;
import com.zy.utils.NetWorkUtils;
import com.zy.vo.LogInfoVo;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;

@Controller
public class LoinController {
    @Autowired
    LoginInfoService loginInfoService;

    @GetMapping({"/login","/"})
    public String toLogin(){
        return "sys/login/login";
    }
    @PostMapping("/login")
    public String login(String username, String password, HttpServletRequest request,String code, HttpSession session, Model model){
        String loginErr = "";
        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken token = new UsernamePasswordToken(username,password);
        //获得存储在session中的验证码
        String sessionCheckCode = (String) session.getAttribute("code");
        //判断验证码是否正确
        if (code==null || !sessionCheckCode.equals(code)){
            //登陆失败，提示验证码不正确！
//            throw new RuntimeException();
            loginErr ="验证码错误！";
        }else{
            subject.login(token);
            LogInfoVo logInfoVo = new LogInfoVo();
            logInfoVo.setLoginname(username);
            logInfoVo.setLoginip(NetWorkUtils.getIpAddr(request));
            logInfoVo.setLogintime(new Date());
            loginInfoService.addLog(logInfoVo);
            return "redirect:/index";
        }
        model.addAttribute("loginErr",loginErr);
        return "/sys/login/login";
    }

    @ExceptionHandler({RuntimeException.class})
    public String handleException(RuntimeException e, Model model){
        String loginErr = "";
        e.printStackTrace();
        if (e instanceof UnknownAccountException){
            loginErr="用户名或者密码或者验证码错误";
        }else if (e instanceof IncorrectCredentialsException){
            loginErr="用户名或者密码或者验证码错误";
        }else {
            loginErr="系统错误，请联系管理员";
        }
        model.addAttribute("loginErr",loginErr);
        return "/sys/login/login";
    }

    //得到登录验证吗
    @RequestMapping("/login/getCode")
    @ResponseBody
    public void getCode(HttpServletResponse response, HttpSession session) throws IOException {

        //HuTool定义图形验证码的长和宽,验证码的位数，干扰线的条数
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(106, 34,4,10);
        //将验证码放入session
        session.setAttribute("code",lineCaptcha.getCode());
        try {
            ServletOutputStream outputStream = response.getOutputStream();
            lineCaptcha.write(outputStream);
            outputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping("/toRegister")
    public String toResister(){
        return "sys/register/register";
    }


}
