package com.zy.vo;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * @author dyqstart
 * @create 2020-04-21 8:23
 */
@Data   //lomok加getting和setting方法
@NoArgsConstructor      //无参构造
@AllArgsConstructor     //全参构造
public class PageResult {

//    private Integer pageNo;//从1开始的页码

//    private interface  pageSize;//页面的容量

    private List rows;//所返回的一页的具体数据

    private long total; //所返回的符合条件的总数量

    //一个静态的方法用于将iPage对象转化为resultVo对象
    public static PageResult getInstance(IPage iPage){
        //静态方法创建一个pageResult对象,iPage的返回的查询数据给力相应的属性
        PageResult pageResult = new PageResult();
        pageResult.rows = iPage.getRecords();
        pageResult.total = iPage.getTotal();
        return pageResult;
    }






}
