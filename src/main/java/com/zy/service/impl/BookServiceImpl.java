package com.zy.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.zy.mapper.BookMapper;
import com.zy.pojo.Book;
import com.zy.service.BookService;
import com.zy.vo.BookVo;
import com.zy.vo.PageResult;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author shkstart
 * @date 2020/6/8 - 9:20
 */
@Service
public class BookServiceImpl implements BookService {
    @Resource
    BookMapper bookMapper;

    @Override
    public void doAdd(Book book) {
        bookMapper.insert(book);
    }

    @Override
    public PageResult findAll(Integer pageNo, Integer pageSize, BookVo bookVo) {
        LambdaQueryWrapper<Book> query=new LambdaQueryWrapper<>();

        query.like(!StringUtils.isEmpty(bookVo.getFlag()),Book::getFlag,bookVo.getFlag())
                .eq(!StringUtils.isEmpty(bookVo.getCustId()),Book::getCustId,bookVo.getCustId())
                .eq(!StringUtils.isEmpty(bookVo.getUserId()),Book::getUserId,bookVo.getUserId())
                .eq(!StringUtils.isEmpty(bookVo.getDate()),Book::getDate,bookVo.getDate());

        //封装分页查询
        Page page = new Page(pageNo,pageSize);
        List<Book> list = bookMapper.findAll(page,query);

        return new PageResult(list,page.getTotal());
    }

    @Override
    public void updateBook(Book book) {
        bookMapper.updateById(book);
    }

    @Override
    public void advise(String activeCode, Integer id) {
        bookMapper.updateBookById(activeCode,id);
    }
}
