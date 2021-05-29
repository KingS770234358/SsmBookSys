<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>所有图书</title>
<%--    <link href="/css/bootstrap.min.css" rel="stylesheet"/>--%>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<%--${pageContext.request.contextPath}--%>
<!-- 使用bootstrap栅格系统 -->
<div class="container">
    <!-- 标题栏 -->
    <!-- row clearfix清除浮动 防止div浮起来-->
    <div class="row clearfix">
        <!-- 栅格系统用起来 横向col 适用中等屏幕md 把空间宽度分成12份之后占的份数 它是列column -->
        <div class="col-md-12 column">
            <!-- 头部 -->
            <div class="page-header">
                <h1 >
                    <small style="margin-left:25%">书籍列表 —————— 显示所有书籍</small>
                </h1>
            </div>
        </div>
    </div>

    <div class="row">
        <!-- 新增书籍的栏 -->
        <div class="col-md-6 column">
            <%-- JSP注解格式 primary 按钮变成蓝色
                 toAddBook--%>
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/books/toAddBooksPage">新增书籍</a>
        </div>
        <!-- 搜索框 -->
        <div class="col-md-6 column">
            <form class="form-inline" action="${pageContext.request.contextPath}/books/queryBooksByNamePlus/" method="post">
                <!-- 接收未查到的消息框 -->
                <span style="color:red;font-weight: bold">${err}</span>
                <input type="text" name="queryName" class="form-control" style="width: 70%;display: inline" placeholder="请输入要查询的书籍名称..."/>
                <input type="submit" value="提交" class="btn btn-primary"/>
            </form>
        </div>
    </div>

<%--    <div class="row">--%>

<%--    </div>--%>


    <!-- 展示书籍信息的表格 -->
    <div class="row clearfix">
        <!-- 栅格系统用起来 横向col 适用中等屏幕md 把屏幕宽度分成12份之后占的份数 它是列column -->
        <div class="col-md-12 column">
            <!-- table-hover鼠标触碰时变色 -->
            <!-- table-striped行颜色交叉变换 -->
            <table class="table table-hover table-striped">
                <thead>
                    <tr>
                        <th>书籍编号</th>
                        <th>书籍名称</th>
                        <th>书籍数量</th>
                        <th>书籍详情</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                <!-- 从Model中取出书本list展示
                     ${list} 也可以 requestScope.get('list')一定要是单引号
                -->
                    <c:forEach var="book" items="${requestScope.get('list')}">
                        <tr>
                            <td>${book.bookID}</td>
                            <td>${book.bookName}</td>
                            <td>${book.bookCounts}</td>
                            <td>${book.detail}</td>
                            <td>
                                <%-- 这里修改只传一个id就够了 信息到后台去查 --%>
<%--                                <a href="${pageContext.request.contextPath}/books/toUpdateBooksPage?bookName=${book.bookName}&bookCounts=${book.bookCounts}&detail=${book.detail}">修改</a>--%>
                                    <a href="${pageContext.request.contextPath}/books/toUpdateBooksPage/${book.bookID}">修改</a>
                                <%-- 中间用 空格|空格 隔开 --%>
                                &nbsp;|&nbsp;
                                <a href="${pageContext.request.contextPath}/books/deleteBooks/${book.bookID}">删除</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
