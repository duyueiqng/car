package com.zy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author dyqstart
 * @create 2020-05-07 14:47
 */
@Controller
public class IndexController {


    @RequestMapping("/index")
    public String index(){
        System.out.println("进入controller!!!");
        return "index";
    }


}
