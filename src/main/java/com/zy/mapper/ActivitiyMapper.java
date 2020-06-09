package com.zy.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zy.pojo.Activitiy;
import com.zy.pojo.Car;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.Date;
import java.util.List;

/**
 * @author dyqstart
 * @create 2020-06-09 11:16
 */
public interface ActivitiyMapper extends BaseMapper<Activitiy> {


    //查询全部或条件查询(ew代表携带条件)page为分页
    @Select("select * from activitiy where datetime>#{ew} and num>0")
    List<Activitiy> findAll(@Param("ew")Date date);

    @Update("UPDATE activitiy SET num=num-1 WHERE id=#{id}")
    void updateById(Integer id);


}
