package com.zy.controller;

import com.zy.pojo.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * @author dyqstart
 * @create 2020-04-14 16:22
 */
//rest风格的路劲
@Controller
public class ForwardController {

    @GetMapping("/{folder1}/{folder2}/{page}/index")
    public String index(@PathVariable("folder1") String folder1, @PathVariable("folder2") String folder2, @PathVariable("page") String page, Model model){
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();
        model.addAttribute("user",user);
        return folder1+"/"+folder2+"/"+page;
    }



}
