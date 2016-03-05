<%-- 
    Document   : emp-purchase-order-delete
    Created on : 2015-12-23, 19:52:21
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>删除购买订单</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            session = request.getSession(true);//获取会话对象
            String employee = (String)session.getAttribute("EMPLOYEE_NO");//从会话中获取工作人员代码
            String empPosition = (String)session.getAttribute("EMPLOYEE_POSITION");//从会话中获取职位
            if(employee==null || !(empPosition.equals("购买订单人员"))){
                response.sendRedirect("index.jsp");
            }
            String purchaseOrderNo = request.getParameter("purchaseOrderNo"); 
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
            conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
            sqlStmt = conn.createStatement();
            //执行SQL语句
            String condition = "DELETE FROM PurchaseOrder WHERE purchaseOrderNo=" + purchaseOrderNo;
            sqlStmt.executeUpdate(condition);
            sqlStmt.close();
            conn.close();
            response.sendRedirect("emp-purchase-order.jsp");
        %>
    </body>
</html>
