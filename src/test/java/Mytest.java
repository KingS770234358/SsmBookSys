import com.wq.pojo.Books;
import com.wq.service.BookService;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Mytest {
    /**
     * 测试bean是否注入成功
     * */
    @Test
    public void test(){
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        BookService bookService =context.getBean("bookServiceImpl", BookService.class);
        for (Books b:bookService.queryAllBooks() ){
            System.out.println(b);
        }
    }
}
