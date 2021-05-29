<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增书籍页面</title>
    <%--    <link href="/css/bootstrap.min.css" rel="stylesheet"/>--%>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
    <div class="row clearfix">
        <!-- 栅格系统用起来 横向col 适用中等屏幕md 把屏幕宽度分成12份之后占的份数 它是列column -->
        <div class="col-md-12 column">
            <!-- 头部 -->
            <div class="page-header">
                <h1 >
                    <small style="margin-left:25%">新增书籍</small>
                </h1>
            </div>
        </div>
    </div>
    <!-- bootstrap form的一些例子 -->
<%--    <form>--%>
<%--        <div class="form-group">--%>
<%--            <label for="exampleInputEmail">Email address:</label>--%>
<%--            <input type="email" class="form-control" id="exampleInputEmail" placeholder="Email"/>--%>
<%--        </div>--%>
<%--        <div class="form-group">--%>
<%--            <label for="exampleInputpassword">Password:</label>--%>
<%--            <input type="password" class="form-control" id="exampleInputpassword" placeholder="password"/>--%>
<%--        </div>--%>
<%--        <div class="form-group">--%>
<%--            <label for="exampleInputFile">File input</label>--%>
<%--            <input type="file" class="form-control" id="exampleInputFile" placeholder="Email"/>--%>
<%--            <p class="help-block">Example block-level help text here.</p>--%>
<%--        </div>--%>
<%--        <div class="check-box">--%>
<%--            <label>--%>
<%--                <input type="checkbox">Check me out--%>
<%--            </label>--%>
<%--        </div>--%>
<%--        <button type="submit" class="btn btn-default">Submit</button>--%>
<%--    </form>--%>
    <!-- 使用bootstrap制作表单
         form-control是常用的文本框选择器
    -->
    <form action="${pageContext.request.contextPath}/books/addBooks" method="POST">
        <!-- required表示必须填写 -->
        <div class="form-group">
            <label>书籍名称:</label>
            <input type="text" name="bookName" class="form-control" required/>
        </div>
        <div class="form-group">
            <label>书籍数量:</label>
            <input type="text" name="bookCounts" class="form-control" required/>
        </div>
        <div class="form-group">
            <label>书籍描述:</label>
            <input type="text" name="detail" class="form-control" required/>
        </div>
        <div class="form-group">
            <input type="submit" class="form-control" value="添加"/>
        </div>
    </form>

    <!-- 一下是最朴素的写法 -->
<%--    <form action="${pageContext.request.contextPath}/books/addBook" method="post">--%>
<%--        书籍名称：<input type="text" name="bookName"><br><br><br>--%>
<%--        书籍数量：<input type="text" name="bookCounts"><br><br><br>--%>
<%--        书籍详情：<input type="text" name="detail"><br><br><br>--%>
<%--        <input type="submit" value="添加">--%>
<%--    </form>--%>
</body>
</html>
