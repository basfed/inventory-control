<%-- 
    Document   : emp-purchase-place
    Created on : 2015-12-22, 20:19:15
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>提交购买订单</title>
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
            String purchaseOrderDescription = request.getParameter("purchaseorderdescription"); 
            String orderDate = request.getParameter("orderdate");
            String dateRequired = request.getParameter("daterequired");
            String shippedDate = request.getParameter("shippeddate");
            String supplierNo = request.getParameter("supplierno");
            String productNo = request.getParameter("productno");
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
            conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
            sqlStmt = conn.createStatement();
            //执行SQL语句
            String sql = "INSERT INTO PurchaseOrder(purchaseOrderDescription,orderDate,dateRequired,shippedDate,freightCharge,purchaseProductNo,supplierNo,employeeNo) VALUES('"+purchaseOrderDescription+"','"+orderDate+"','"+dateRequired+"','"+shippedDate+"','10','"+productNo+"','"+supplierNo+"','"+employee+"')"; 
            sqlStmt.executeUpdate(sql);
            sqlStmt.close();
            conn.close();
            response.sendRedirect("emp-purchase-order.jsp");
        %>
    </body>
</html>
