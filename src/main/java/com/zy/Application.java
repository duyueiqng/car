package com.zy;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@MapperScan(basePackages = "com.zy.mapper")
@EnableScheduling   // 2.开启定时任务
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class,args);
    }
}
