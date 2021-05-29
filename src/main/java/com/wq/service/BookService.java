package com.wq.service;

import com.wq.pojo.Books;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;
/***
 * service层的接口跟dao接口存在细微差别
 *  * 这个案例中直接使用DAO层
 *
 */
public interface BookService {
    // 增加一本书
    int addBook(Books books);

    // 删除一本书
    int deleteBooks(int bookID);

    // 修改一本书
    int updateBook(Books books);

    // 因为底层mapper.xml需要,要将这个ID放入一个map才行
    List<Books> queryBook(Map map);

    // 查询所有的书
    List<Books> queryAllBooks();

    // 按书名查书
    List<Books> queryBooksByName(String bookName);

    List<Books> queryBooksByNamePlus(String queryName);

}
