<%-- 
    Document   : user-login
    Created on : 2015-12-20, 15:22:48
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>客户登录</title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <%
            String username = "";
            String password = "";
            Cookie[] cookies = request.getCookies();//获取请求相关的cookie
            if(cookies != null){
                for(int i=0;i<cookies.length;i++){
                    if(cookies[i].getName().equals("USERNAME")){
                        username = cookies[i].getValue();
                        username = java.net.URLDecoder.decode(username,"UTF-8");//取cookie值时解码
                    }
                    if(cookies[i].getName().equals("PASSWORD")){
                        password = cookies[i].getValue();
                        password = java.net.URLDecoder.decode(password,"UTF-8");
                    }
                }
            }
        %>
        <div class="wrapper">
            <div class="header">
                <h1 class="title">客户登录</h1>
                <div class="trigger">
                    <a href="user-login.jsp" style="color: #333;">登录</a>
                    <span>&nbsp;|&nbsp;</span>
                    <a href="user-register.jsp">注册</a>
                </div>
            </div>
            <form class="form-login" method="POST" action="user-login-check.jsp">
                <input type="text" name="username" value="<%=username%>" placeholder="客户姓名">
                <input type="password" name="password" value="<%=password%>" placeholder="密码">
                <input type="checkbox" name="save" value="yes" checked>
                <label>记住登录状态</label>
                <input type="submit" name="login" value="登录">
                <input type="reset" name="reset" value="重置">
            </form>
        </div>
    </body>
</html>
