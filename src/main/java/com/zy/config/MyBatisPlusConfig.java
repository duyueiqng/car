package com.zy.config;

import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import com.github.dreamyoung.mprelation.AutoMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author dyqstart
 * @create 2020-04-21 8:20
 */
@Configuration
public class MyBatisPlusConfig {

    //将分页的拦截器交个spring管理
    @Bean
    public PaginationInterceptor paginationInterceptor(){
        return new PaginationInterceptor();
    }

    @Bean
    public AutoMapper autoMapper(@Autowired(required=false) ApplicationContext applicationContext) {
        return new AutoMapper(applicationContext, new String[] { "com.zy.pojo" }); //配置ApplicationContext及实体类所在包
    }


}
