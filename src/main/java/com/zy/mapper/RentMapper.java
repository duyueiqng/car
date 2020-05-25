package com.zy.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zy.pojo.Renttable;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @author dyqstart
 * @create 2020-05-18 9:04
 */
public interface RentMapper extends BaseMapper<Renttable> {

    //查询全部或条件查询(ew代表携带条件)page为分页
    @Select("select * from renttable ${ew.customSqlSegment}")
    List<Renttable> findAll(Page page, @Param("ew") Wrapper wrapper);

    //归还查询的数据


}
