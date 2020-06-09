package com.zy.mapper;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zy.pojo.Book;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * @author shkstart
 * @date 2020/6/8 - 9:21
 */
public interface BookMapper extends BaseMapper<Book> {

    @Select("select * from book ${ew.customSqlSegment}")
    List<Book> findAll(Page page, @Param("ew") Wrapper wrapper);

    @Update("update book set remark =#{activeCode} where id =#{id}")
    void updateBookById(@Param("activeCode") String activeCode, @Param("id") Integer id);
}
