<%-- 
    Document   : emp-product-place
    Created on : 2015-12-23, 16:54:21
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>提交产品信息</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            session = request.getSession(true);//获取会话对象
            String employee = (String)session.getAttribute("EMPLOYEE_NO");//从会话中获取工作人员代码
            String empPosition = (String)session.getAttribute("EMPLOYEE_POSITION");//从会话中获取职位
            if(employee==null || !(empPosition.equals("确定交易人员"))){
                response.sendRedirect("index.jsp");
            }
            String productName = request.getParameter("productName");
            String serialNo = request.getParameter("serialNo");
            String unitPrice = request.getParameter("unitPrice");
            String quantityOnHand = request.getParameter("quantityOnHand");
            String reorderLevel = request.getParameter("reorderLevel");
            String reorderQuantity = request.getParameter("reorderQuantity");
            String reorderLeadTime = request.getParameter("reorderLeadTime");
            String categoryNo = request.getParameter("categoryNo");
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
            conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
            sqlStmt = conn.createStatement();
            //执行SQL语句
            String sql = "INSERT INTO Product(productName,serialNo,unitPrice,quantityOnHand,reorderLevel,reorderQuantity,reorderLeadTime,categoryNo) VALUES('"+productName+"','"+serialNo+"','"+unitPrice+"','"+quantityOnHand+"','"+reorderLevel+"','"+reorderQuantity+"','"+reorderLeadTime+"','"+categoryNo+"')"; 
            sqlStmt.executeUpdate(sql);
            sqlStmt.close();
            conn.close();
            response.sendRedirect("emp-product-add.jsp");
        %>
    </body>
</html>
