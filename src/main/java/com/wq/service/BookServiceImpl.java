package com.wq.service;

import com.wq.mapper.BookMapper;
import com.wq.pojo.Books;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/***
 * 业务层service层的实现类
 * [业务层调用DAO层就对了]
 * ===所以要将DAO层组合进来
 */
//@Service
public class BookServiceImpl implements BookService {

    // 组合DAO层
//     @Autowired
    private BookMapper bookMapper;
    // 编写它的set方法 这样Spring就可以托管它
    public void setBookMapper(BookMapper bookMapper) {
        this.bookMapper = bookMapper;
    }

    @Override
    public int addBook(Books books) {
        return bookMapper.addBook(books);
    }

    @Override
    public int deleteBooks(int bookID) {
        return bookMapper.deleteBooks(bookID);
    }

    @Override
    public int updateBook(Books books) {
        return bookMapper.updateBook(books);
    }

    @Override
    public List<Books> queryBook(Map map) {
        return bookMapper.queryBook(map);
    }

    @Override
    public List<Books> queryAllBooks() {
        return bookMapper.queryAllBooks() ;
    }

    @Override
    public List<Books> queryBooksByName(String bookName) {
        return bookMapper.queryBooksByName(bookName);
    }

    @Override
    public List<Books> queryBooksByNamePlus(String queryName){
        // 省去查找数据库
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("bookName",queryName);
        map.put("detail",queryName);
        try{
            int n = Integer.parseInt(queryName);
            map.put("bookCounts",n);
        }catch (Exception e){
            System.out.println("not a number");
        }
        List<Books> list = bookMapper.queryBook(map);
        return list;
    }
}
