<%-- 
    Document   : emp-deliver
    Created on : 2015-12-24, 9:44:17
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>操作客户订单</title>
        <link rel="stylesheet" href="css/style.css" />
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
        %>
        <div class="wrapper">
            <div class="header">
                <h1>发货</h1>
                <h2>你有权对以下的客户订单进行发货操作。</h2>
                <div class="trigger">
                    你好，<a><%=employee%></a>
                </div>
                <ul class="nav">
                    <li><a href="emp-deliver.jsp">发货</a></li>
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
                    String sqlQuery = "SELECT * FROM UserOrder";
                    sqlRst = sqlStmt.executeQuery(sqlQuery);
            %>
            <div class="content">
                <h2>客户订单</h2>
                <table>
                    <tr>
                        <td>客户订单号码</td>
                        <td>客户代码</td>
                        <td>客户姓名</td>
                        <td>客户购买日期</td>
                        <td>客户订单说明</td>
                        <td>客户住址</td>
                        <td>客户电话号码</td>
                        <td>产品代码</td>
                        <td>订购数量</td>
                        <td>总价</td>
                        <td>客户订单状态</td>
                    </tr>
                    <% while(sqlRst.next()){//取得下一条记录 %>
                    <tr>
                        <td><%=sqlRst.getString("userOrderNo")%></td>
                        <td><%=sqlRst.getString("userNo")%></td>
                        <td><%=sqlRst.getString("userName")%></td>
                        <td><%=sqlRst.getString("userOrderDate")%></td>
                        <td><%=sqlRst.getString("userOrderDescription")%></td>
                        <td><%=sqlRst.getString("userAddress")%></td>
                        <td><%=sqlRst.getString("userTelNo")%></td>
                        <td><%=sqlRst.getString("productNo")%></td>
                        <td><%=sqlRst.getString("orderQuantity")%></td>
                        <td><%=sqlRst.getString("totalPrice")%></td>
                        <% if((sqlRst.getString("userOrderStatus")).equals("已付款")){ %>
                            <td><a href="emp-deliver-place.jsp?userOrderNo=<%=sqlRst.getString("userOrderNo")%>"><%=sqlRst.getString("userOrderStatus")%></a></td>
                        <% }else{ %>
                            <td><%=sqlRst.getString("userOrderStatus")%></td>
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
