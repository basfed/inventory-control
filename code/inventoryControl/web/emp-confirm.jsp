<%-- 
    Document   : confirm
    Created on : 2015-12-20, 20:12:40
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>确定交易</title>
        <link rel="stylesheet" href="css/style.css" />
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
        %>
        <div class="wrapper">
            <div class="header">
                <h1>确定交易</h1>
                <h2>你有权对以下的购买订单确认或删除，确定就添加到交易表中。</h2>
                <div class="trigger">
                    你好，<a><%=employee%></a>
                </div>
                <ul class="nav">
                    <li><a href="emp-confirm.jsp">确定交易</a></li>
                    <li><a href="emp-product-add.jsp">增加产品</a></li>
                </ul>
            </div>
            <%
                java.sql.Connection conn = null;
                java.lang.String strConn;
                java.sql.Statement sqlStmt = null;//语句对象
                java.sql.Statement sqlStmt1 = null;//语句对象
                java.sql.ResultSet sqlRst = null;//结果集对象
                java.sql.ResultSet sqlRst1 = null;//结果集对象
                try{
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
                    conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                    sqlStmt = conn.createStatement();
                    //执行SQL语句
                    String sqlQuery = "SELECT * FROM PurchaseOrder";
                    sqlRst = sqlStmt.executeQuery(sqlQuery);
            %>
            <div class="content">
                <h2>购买订购表</h2>
                <table>
                    <tr>
                        <td>购买订单代码</td>
                        <td>购买订单描述</td>
                        <td>订货日期</td>
                        <td>交货日期</td>
                        <td>发货日期</td>
                        <td>货运费</td>
                        <td>供应商代码</td>
                        <td>工作人员代码</td>
                        <td>是否交易</td>
                        <td>是否删除</td>
                    </tr>
                    <% while(sqlRst.next()){//取得下一条记录 %>
                    <tr>
                        <td><%=sqlRst.getString("purchaseOrderNo")%></td>
                        <td><%=sqlRst.getString("purchaseOrderDescription")%></td>
                        <td><%=sqlRst.getString("orderDate")%></td>
                        <td><%=sqlRst.getString("dateRequired")%></td>
                        <td><%=sqlRst.getString("shippedDate")%></td>
                        <td><%=sqlRst.getString("freightCharge")%></td>
                        <td><%=sqlRst.getString("supplierNo")%></td>
                        <td><%=sqlRst.getString("employeeNo")%></td>
                        <td><a href="emp-confirm-place.jsp?purchaseOrderNo=<%=sqlRst.getString("purchaseOrderNo")%>&purchaseProductNo=<%=sqlRst.getString("purchaseProductNo")%>">交易</a></td>
                        <td><a href="emp-confirm-place.jsp?purchaseOrderNo=<%=sqlRst.getString("purchaseOrderNo")%>">删除</a></td>
                    </tr>
                    <% 
                    }
                    sqlStmt1 = conn.createStatement();
                    //执行SQL语句
                    String sqlQuery1 = "SELECT * FROM [Transaction]";
                    sqlRst1 = sqlStmt.executeQuery(sqlQuery1);
                    %>
                </table>
                <h2>交易表</h2>
                <table>
                    <tr>
                        <td>交易代码</td>
                        <td>交易日期</td>
                        <td>交易说明</td>
                        <td>单价</td>
                        <td>单位订单</td>
                        <td>收到订单</td>
                        <td>销量</td>
                        <td>单位损耗</td>
                        <td>总价</td>
                        <td>产品代码</td>
                        <td>购买订单代码</td>
                    </tr>
                    <% while(sqlRst1.next()){//取得下一条记录 %>
                    <tr>
                        <td><%=sqlRst1.getString("transactionNo")%></td>
                        <td><%=sqlRst1.getString("transactionDate")%></td>
                        <td><%=sqlRst1.getString("transactionDescription")%></td>
                        <td><%=sqlRst1.getString("unitPrice")%></td>
                        <td><%=sqlRst1.getString("unitsOrdered")%></td>
                        <td><%=sqlRst1.getString("unitsReceived")%></td>
                        <td><%=sqlRst1.getString("unitsSold")%></td>
                        <td><%=sqlRst1.getString("unitsWastage")%></td>
                        <td><%=sqlRst1.getString("totalPrice")%></td>
                        <td><%=sqlRst1.getString("productNo")%></td>
                        <td><%=sqlRst1.getString("purchaseOrderNo")%></td>
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
