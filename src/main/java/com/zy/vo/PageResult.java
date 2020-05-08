package com.zy.vo;

import com.baomidou.mybatisplus.core.metadata.IPage;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data//get set tostring
@AllArgsConstructor //有参构造
@NoArgsConstructor//无参构造
public class PageResult {


    private List rows;//一行数据
    private Long tatal;//符合条件的总记录数

    public static PageResult setPageResult(IPage iPage){
        PageResult pageResult = new PageResult();
        pageResult.rows=iPage.getRecords();
        pageResult.tatal=iPage.getTotal();
        return  pageResult;
    }
}
