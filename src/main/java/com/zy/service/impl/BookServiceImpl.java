package com.zy.service.impl;

import com.zy.mapper.BookMapper;
import com.zy.pojo.Book;
import com.zy.service.BookService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

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
}
