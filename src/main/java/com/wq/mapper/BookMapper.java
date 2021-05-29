package com.wq.mapper;

import com.wq.pojo.Books;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/***
 * 对book pojo进行操作的接口
 * 实现 增 删 改 查(一本 全部)
 */
public interface BookMapper {
    // 增加一本书
    int addBook(Books books);

    // 删除一本书
    int deleteBooks(@Param("bookID") int bookID);

    // 修改一本书
    int updateBook(Books books);

    // 按照查询一本书(Map里放入bookID即可)
    List<Books> queryBook(Map paramMap);

    // 查询所有的书
    List<Books> queryAllBooks();

    // 按书名查书
    List<Books> queryBooksByName(@Param("bookName") String bookName);


}
