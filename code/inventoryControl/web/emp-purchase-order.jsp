<%-- 
    Document   : emp-purchase-order
    Created on : 2015-12-22, 21:08:08
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>购买订单</title>
        <link rel="stylesheet" href="css/style.css" />
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
        %>
        <div class="wrapper">
            <div class="header">
                <h1>购买订单</h1>
                <h2>所有购买订单人员提出的购买订单</h2>
                <div class="trigger">
                    你好，<a><%=employee%></a>
                </div>
                <ul class="nav">
                    <li><a href="emp-purchase.jsp">提出购买订单</a></li>
                    <li><a href="emp-purchase-order.jsp">购买订单</a></li>
                </ul>
            </div>
            <%
                java.sql.Connection conn = null;
                java.lang.String strConn;
                java.sql.Statement sqlStmt = null;//语句对象
                java.sql.ResultSet sqlRst = null;//结果集对象
                try{
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
                    conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                    sqlStmt = conn.createStatement();
                    //执行SQL语句
                    String sqlQuery = "SELECT * FROM PurchaseOrder";
                    sqlRst = sqlStmt.executeQuery(sqlQuery);
            %>
            <div class="content">
                <h2>购买订单表</h2>
                <table>
                    <tr>
                        <td>购买订单代码</td>
                        <td>购买订单描</td>
                        <td>订货日期</td>
                        <td>交货日期</td>
                        <td>发货日期</td>
                        <td>货运费</td>
                        <td>购买产品代码</td>
                        <td>供应商代码</td>
                        <td>工作人员代码</td>
                        <td>删除</td>
                    </tr>
                    <% while(sqlRst.next()){//取得下一条记录 %>
                    <tr>
                        <td><%=sqlRst.getString("purchaseOrderNo")%></td>
                        <td><%=sqlRst.getString("purchaseOrderDescription")%></td>
                        <td><%=sqlRst.getString("orderDate")%></td>
                        <td><%=sqlRst.getString("dateRequired")%></td>
                        <td><%=sqlRst.getString("shippedDate")%></td>
                        <td><%=sqlRst.getString("freightCharge")%></td>
                        <td><%=sqlRst.getString("purchaseProductNo")%></td>
                        <td><%=sqlRst.getString("supplierNo")%></td>
                        <td><%=sqlRst.getString("employeeNo")%></td>
                        <% if(employee.equals(sqlRst.getString("employeeNo"))){ %>
                        <td><a href="emp-purchase-order-delete.jsp?purchaseOrderNo=<%=sqlRst.getString("purchaseOrderNo")%>">删除</a></td>
                        <% }else{ %>
                        <td>删除</td>
                        <% } %>
                    </tr>
                    <% } %>
                </table>
                <%
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
                %>
            </div>
        </div>
    </body>
</html>
