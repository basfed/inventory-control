<%-- 
    Document   : emp-login
    Created on : 2015-12-20, 15:12:11
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>工作人员登录</title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <%
            String employeeNo = "";
            String empPassword = "";
            Cookie[] cookies = request.getCookies();//获取请求相关的cookie
            if(cookies != null){
                for(int i=0;i<cookies.length;i++){
                    if(cookies[i].getName().equals("EMPLOYEENO")){
                        employeeNo = cookies[i].getValue();
                        employeeNo = java.net.URLDecoder.decode(employeeNo,"UTF-8");//取cookie值时解码
                    }
                    if(cookies[i].getName().equals("EMPPASSWORD")){
                        empPassword = cookies[i].getValue();
                        empPassword = java.net.URLDecoder.decode(empPassword,"UTF-8");
                    }
                }
            }
        %>
        <div class="wrapper">
            <div class="header">
                <h1 class="title">工作人员登录</h1>
                <div class="trigger">
                    <a href="emp-login.jsp" style="color: #333;">登录</a>
                </div>
            </div>
            <form class="form-login" method="POST" action="emp-login-check.jsp">
                <input type="text" name="employeeno" value="<%=employeeNo%>" placeholder="工作人员编号">
                <input type="password" name="emppassword" value="<%=empPassword%>" placeholder="密码">
                <input type="checkbox" name="save" value="yes" checked>
                <label>记住登录状态</label>
                <input type="submit" name="login" value="登录">
                <input type="reset" name="reset" value="重置">
            </form>
        </div>
    </body>
</html>
