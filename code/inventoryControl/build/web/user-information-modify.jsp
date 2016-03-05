<%-- 
    Document   : user-information-modify
    Created on : 2015-12-24, 14:33:16
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>客户信息修改</title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            session = request.getSession(true);//获取会话对象
            String userName = (String)session.getAttribute("USER_NAME");//从会话中获取客户名
            if(userName==null){
                response.sendRedirect("index.jsp");
            }
        %>
        <div class="wrapper">
            <div class="header">
                <h1>客户信息修改</h1>
                <h2>认真修改客户信息</h2>
                <div class="trigger">
                    你好，<a><%=userName%></a>
                </div>
                <ul class="nav">
                    <li><a href="user-purchase.jsp">客户购买</a></li>
                    <li><a href="user-purchase-history.jsp">历史购买</a></li>
                </ul>
            </div>
            <div class="content">
                <h2>客户信息修改</h2>
                <form class="form-purchase" method="POST" action="user-information-modify-place.jsp">
                    <p>客户收货地址</p>
                    <input type="text" name="userAddress" placeholder="客户收货地址">
                    <p>客户电话号码</p>
                    <input type="tel" name="userTelNo" placeholder="客户电话号码">
                    <input type="submit" value="修改">
                </form1>
            </div>
        </div>
    </body>
</html>
