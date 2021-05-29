package com.wq.controller;

import com.wq.pojo.Books;
import com.wq.service.BookService;
import com.wq.service.BookServiceImpl;
import javafx.beans.binding.ObjectExpression;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/books")
public class BooksController {
    //Controller层调用Service层

    // 在Spring容器中(spring-service.xml)注入了"com.wq.service.BookServiceImpl"对象
    // 将这个BookServiceImpl通过注解注入给bookService
    // [接口的实现类可以注入给接口]==>注入做的就是这件事 UserMapper userMapper = new UserMapperImpl();
    @Autowired
    @Qualifier("bookServiceImpl")
    private BookService bookService;
//    // 手动注入 测试完记得改成上面那种。。。。
//    private BookService bookService = new BookServiceImpl();

    // 查询全部的书籍,并返回到书籍展示页面
    @RequestMapping("/listBooks")
    public String listBooks(Model model){
        List<Books> list = bookService.queryAllBooks();
        model.addAttribute("list",list);
        return "listBooks";
    }

    // 跳转到增加书籍页面
    @RequestMapping("/toAddBooksPage")
    public String toAddBooksPage(){
        return "addBooks";
    }
    // 在添加书籍页面填写好书籍信息后 提交到这里
    @RequestMapping("/addBooks")
    public String addBook(Books books){
        // 这里接收一个对象参数, 表单里的控件name 要跟对象的属性名一一对应!!!!
        // 参数的类型更要对应 对象接收一个int 就不能传入一个string
        System.out.println("add books == > "+books  );
        bookService.addBook(books);
        // 添加完通过重定向(客户端再次发请求的方式)
        return "redirect:/books/listBooks";
    }

    // 跳转到修改页面
    @RequestMapping("/toUpdateBooksPage/{bookID}")
    public String toUpdateBooksPage(@PathVariable int bookID, Model model){
        // 跳转过来的时候 要展示原来图书的信息 所以需要携带数据

        System.out.println("update book"+bookID);
        Map<String, Integer> map = new HashMap<String, Integer>();
        map.put("bookID", bookID);
        List<Books> books = bookService.queryBook(map);
        System.out.println("update book"+books.get(0));
        // 传给更新页面 更新页面按照 books 取值
        model.addAttribute("books",books.get(0));
        return "updateBooks";
    }
    // 在修改书籍页面填写好书籍信息后 提交到这里
    @RequestMapping("/updateBooks")
    public String updateBooks(Books books){
        // 这里接收一个对象参数, 表单里的控件name 要跟对象的属性名一一对应!!!!
        // 参数的类型更要对应 对象接收一个int 就不能传入一个string
        bookService.updateBook(books);
        // 添加完通过重定向(客户端再次发请求的方式)
        return "redirect:/books/listBooks";
    }

    // 删除书籍
    // 在修改书籍页面填写好书籍信息后 提交到这里
    @RequestMapping("/deleteBooks/{bookID}")
    public String deleteBooks(@PathVariable("bookID") int bookID){
        bookService.deleteBooks(bookID);
        return "redirect:/books/listBooks";
    }

    // 按书名查找
    @RequestMapping("/queryBooksByName")
    public String queryBooksByName(String queryName, Model model){
        // 省去查找数据库
        if("".equals(queryName))return "redirect:/books/listBooks";
        List<Books> list = bookService.queryBooksByName(queryName);
        if(list.size()>0){
            model.addAttribute("list",list);
            return "listBooks";
        }else {
            // 可以给用户提示 在做决定
            return "redirect:/books/listBooks";
        }
    }
    // 按书名查找
    @RequestMapping("/queryBooksByNamePlus")
    public String queryBooksByNamePlus(String queryName, Model model){
        if("".equals(queryName))return "redirect:/books/listBooks";
        List<Books> list = bookService.queryBooksByNamePlus(queryName);
        if(list.size()>0){
            model.addAttribute("list",list);
            model.addAttribute("err","");
            return "listBooks";
        }else {
            List<Books> listAll = bookService.queryAllBooks();
            model.addAttribute("list",listAll);
            // 可以给用户提示 在做决定
            model.addAttribute("err","未查到!");
            return "listBooks";
        }
    }
}
