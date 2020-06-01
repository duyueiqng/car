package com.zy.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.zy.pojo.Loginfo;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author Mxb
 * @version 1.0
 * @date 2019/11/1 8:44
 */
@Data
public class LogInfoVo extends Loginfo {
    //分页参数
//    private Integer page;
//    private Integer limit;

    //时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date startTime;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private Date endTime;

    //接收多个id
    private Integer[] ids;


}
