<%-- 
    Document   : emp-accept-make
    Created on : 2015-12-23, 20:43:23
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>修改交易表、产品表</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            session = request.getSession(true);//获取会话对象
            String employee = (String)session.getAttribute("EMPLOYEE_NO");//从会话中获取工作人员代码
            String empPosition = (String)session.getAttribute("EMPLOYEE_POSITION");//从会话中获取职位
            if(employee==null || !(empPosition.equals("验收货物人员"))){
                response.sendRedirect("index.jsp");
            }
            String transactionNo = request.getParameter("transactionNo");
            String unitPrice = request.getParameter("unitPrice");
            String unitsOrdered = request.getParameter("unitsOrdered");
            String unitsReceived = request.getParameter("unitsReceived");
            String unitsSold = request.getParameter("unitsSold");
            String unitsWastage = request.getParameter("unitsWastage");
            String productNo = request.getParameter("productNo");
            float totalPrice = ((Integer.parseInt(unitsOrdered)-Integer.parseInt(unitsWastage))*(Float.parseFloat(unitPrice)));
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            java.sql.Statement sqlStmt1 = null;//语句对象
            java.sql.Statement sqlStmt2 = null;//语句对象
            java.sql.ResultSet sqlRst = null;//结果集对象
            try{
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
                conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                sqlStmt = conn.createStatement();
                //执行SQL语句
                String sql = "UPDATE [Transaction] SET unitsReceived='"+unitsReceived+"',unitsSold='"+unitsSold+"',unitsWastage='"+unitsWastage+"',totalPrice='"+totalPrice+"' WHERE transactionNo="+transactionNo;
                sqlStmt.executeUpdate(sql);
                sqlStmt1 = conn.createStatement();
                //执行SQL语句
                String sql1 = "SELECT quantityOnHand FROM Product WHERE productNo="+productNo;
                sqlRst = sqlStmt1.executeQuery(sql1);
                while(sqlRst.next()){//取得下一条记录
                    int quantityOnHand = Integer.parseInt(sqlRst.getString("quantityOnHand"));
                    int a = Integer.parseInt(unitsReceived)-Integer.parseInt(unitsSold);
                    quantityOnHand = Integer.parseInt(unitsReceived) + a;
                    String reorderLevel = "";
                    if(quantityOnHand > 5000){
                        reorderLevel = "低";
                    }else if(quantityOnHand > 1000){
                        reorderLevel = "中";
                    }else{
                        reorderLevel = "高";
                    }
                    sqlStmt2 = conn.createStatement();
                    //执行SQL语句
                    String sql2 = "UPDATE Product SET quantityOnHand='"+quantityOnHand+"',reorderLevel='"+reorderLevel+"',reorderQuantity='"+unitsSold+"' WHERE productNo="+productNo;
                    sqlStmt2.executeUpdate(sql2);
                }
            }catch(Exception e){
                out.println(e.toString());
                e.printStackTrace();
            }finally{
                try{
                    if(conn!=null) conn.close();
                }catch(Exception e){
                    out.println(e.toString());
                    e.printStackTrace();
                }
            }
            response.sendRedirect("emp-accept.jsp");
        %>
    </body>
</html>
