package com.zy.pojo;


import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;

@Data
public class Activitiy {

    private Integer id;

    /**
     * 活动名称
     */
    private String activities;

    /**
     * 赠送礼品
     */
    private String gifts;

    /**
     * 礼品数量
     */
    private Integer num;

    /**
     * 活动时间
     */
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm")
    private LocalDateTime datetime;

    /**
     * 活动内容
     */
    private String content;


}
