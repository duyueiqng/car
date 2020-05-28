package com.zy.vo;

import com.zy.pojo.Checktable;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * @author shkstart
 * @date 2020/5/28 - 14:57
 */
@Data
public class CheckedVo extends Checktable{

    private Integer page;
    private Integer limit;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date startTime;

    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date endTime;
}
