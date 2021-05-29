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
                <small style="margin-left:25%">修改书籍</small>
            </h1>
        </div>
    </div>
</div>
<form action="${pageContext.request.contextPath}/books/updateBooks/" method="POST">
    <!-- required表示必须填写 -->
    <%-- 隐藏域传递bookID --%>
    <div class="form-group">
        <input type="hidden" name="bookID" class="form-control" value="${books.bookID}"/>
    </div>
    <div class="form-group">
        <label>书籍名称:</label>
        <input type="text" name="bookName" class="form-control" required value="${books.bookName}"/>
    </div>
    <div class="form-group">
        <label>书籍数量:</label>
        <input type="text" name="bookCounts" class="form-control" required value="${books.bookCounts}"/>
    </div>
    <div class="form-group">
        <label>书籍描述:</label>
        <input type="text" name="detail" class="form-control" required value="${books.detail}"/>
    </div>
    <div class="form-group">
        <input type="submit" class="form-control" value="修改"/>
    </div>
</form>
</body>
</html>
