package com.zy.service;

import com.zy.pojo.Book; /**
 * @author shkstart
 * @date 2020/6/8 - 9:19
 */
public interface BookService {
    /**
     * 增加预订
     * @param book
     */
    void doAdd(Book book);
}
