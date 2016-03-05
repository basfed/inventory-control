<%-- 
    Document   : user-register-add
    Created on : 2015-12-21, 20:44:34
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>客户注册是否合法</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            String userName = request.getParameter("username"); 
            String password = request.getParameter("password");
            String userAddress = request.getParameter("useraddress");
            String userTelNo = request.getParameter("usertelno");
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
            conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
            sqlStmt = conn.createStatement();
            //执行SQL语句
            if((userName!=null&&userName.length()!=0)&&(password!=null&&password.length()!=0)&&(userAddress!=null&&userAddress.length()!=0)&&(userTelNo!=null&&userTelNo.length()!=0)){
                String sql = "INSERT INTO [User](userName,userPassword,userAddress,userTelNo) VALUES('"+userName+"','"+password+"','"+userAddress+"','"+userTelNo+"')"; 
                sqlStmt.executeUpdate(sql);
                sqlStmt.close();
                conn.close();
                response.sendRedirect("user-login.jsp");
            }else{
                response.sendRedirect("user-register.jsp");
            }
        %>
    </body>
</html>
