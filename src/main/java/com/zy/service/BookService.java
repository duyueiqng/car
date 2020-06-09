package com.zy.service;

import com.zy.pojo.Book;
import com.zy.vo.BookVo;
import com.zy.vo.PageResult;

/**
 * @author shkstart
 * @date 2020/6/8 - 9:19
 */
public interface BookService {
    /**
     * 增加预订
     * @param book
     */
    void doAdd(Book book);

    /**
     * 查询预订
     * @param pageNo
     * @param pageSize
     * @param bookVo
     * @return
     */
    PageResult findAll(Integer pageNo, Integer pageSize, BookVo bookVo);

    /**
     * 更新Book
     * @param book
     */
    void updateBook(Book book);

    /**
     * 更改通知结果
     * @param activeCode
     * @param id
     */
    void advise(String activeCode, Integer id);
}
