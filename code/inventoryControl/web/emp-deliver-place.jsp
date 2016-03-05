<%-- 
    Document   : emp-deliver-update
    Created on : 2015-12-24, 13:44:24
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>修改客户订单状态</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            session = request.getSession(true);//获取会话对象
            String employee = (String)session.getAttribute("EMPLOYEE_NO");//从会话中获取工作人员代码
            String empPosition = (String)session.getAttribute("EMPLOYEE_POSITION");//从会话中获取职位
            if(employee==null || !(empPosition.equals("发货人员"))){
                response.sendRedirect("index.jsp");
            }
            String userOrderNo = request.getParameter("userOrderNo");
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            java.sql.ResultSet sqlRst = null;//结果集对象
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
            conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
            sqlStmt = conn.createStatement();
            //执行SQL语句
            String sql = "UPDATE UserOrder SET userOrderStatus='已发货' WHERE userOrderNo="+userOrderNo;
            sqlStmt.executeUpdate(sql);
            sqlStmt.close();
            conn.close();
            response.sendRedirect("emp-deliver.jsp");
        %>
    </body>
</html>
