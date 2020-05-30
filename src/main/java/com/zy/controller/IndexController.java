package com.zy.controller;

import com.zy.pojo.Menu;
import com.zy.pojo.User;
import com.zy.service.PermissionService;
import com.zy.utils.Constants;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-07 14:47
 */
@Controller
public class IndexController {


    @Resource
    PermissionService permissionService;

    @RequestMapping("/index")
    public String index(Model model){
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();
        Session session = subject.getSession();
        session.setAttribute(Constants.USER_SESSION,user);
        List<Menu> permissionList = permissionService.searchMenuList(user.getUserRole());
        model.addAttribute("menuList",permissionList);
        return "sys/menu/index";
    }



}
