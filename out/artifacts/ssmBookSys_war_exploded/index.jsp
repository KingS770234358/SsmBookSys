<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>首页</title>
    <style>
      /* 层叠样式表的注释语法
         a h3 都是标签选择器
       */
      a{
        /* 去掉链接的下划线 */
        text-decoration:none;
        /* 字的颜色 */
        color:black;
        font-size: 18px;
      }
      h3{
        width:180px;
        height: 38px;
        /** auto就有可能居中了 */
        margin: 100px auto;
        /* 文本居中 */
        text-align: center;
        /** 行高跟height一样就居中了 */
        line-height: 38px;
        /* 背景颜色 */
        background: deepskyblue;
        /* 圆点边框 */
        border-radius: 5px;
      }
    </style>
  </head>
  <body>
  <h3>
    <a href="${pageContext.request.contextPath}/books/listBooks">进入书籍页面</a>
  </h3>
  </body>
</html>
