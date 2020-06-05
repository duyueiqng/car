package com.zy.controller;

import lombok.SneakyThrows;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import org.apache.ibatis.io.Resources;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

/**
 * @author dyqstart
 * @create 2020-06-05 11:52
 */
@Controller
@RequestMapping("/sys/rent")
public class JasperController {


    @Resource
    private DataSource dataSource;


    @SneakyThrows
    @GetMapping("/exportPdf1")
    public void jasperPdf1(HttpServletResponse response,String id){
        ServletOutputStream servletOutputStream = response.getOutputStream();
        System.out.println("获得的打印:"+id);
        //文件写入流
        InputStream inputStream = Resources.getResourceAsStream("jasper/zuLin.jasper");
        //跳过dao层,获取一个连接对象
        Connection connection = dataSource.getConnection();
        //对象键值方式给传值
        Map parameters=new HashMap();
        parameters.put("Parameter1",id);

        JasperRunManager.runReportToPdfStream(inputStream,servletOutputStream,parameters,connection);
        //设置PDF格式
        response.setContentType("application/pdf");
        servletOutputStream.flush();
        servletOutputStream.close();

    }


}
