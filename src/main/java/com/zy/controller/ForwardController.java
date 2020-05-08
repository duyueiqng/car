package com.zy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

/**
 * @author dyqstart
 * @create 2020-04-14 16:22
 */
//rest风格的路劲
@Controller
public class ForwardController {

    @GetMapping("/{folder}/{page}/index")
    public String index(@PathVariable("folder") String folder,@PathVariable("page") String page){
        return folder+"/"+page;
    }



}
