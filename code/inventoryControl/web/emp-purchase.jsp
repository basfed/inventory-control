<%-- 
    Document   : purchase
    Created on : 2015-12-20, 20:10:53
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>提出购买订单</title>
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
                <h1>提出购买订单</h1>
                <h2>你有权对以下产品表中的产品提出购买订单</h2>
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
                    String sqlQuery = "SELECT * FROM Product";
                    sqlRst = sqlStmt.executeQuery(sqlQuery);
            %>
            <div class="content">
                <h2>产品表</h2>
                <table>
                    <tr>
                        <td>产品代码</td>
                        <td>产品名称</td>
                        <td>产品编号</td>
                        <td>产品单价</td>
                        <td>现存数量</td>
                        <td>订货点水平</td>
                        <td>再订购数量</td>
                        <td>订货提前期</td>
                        <td>产品分类代码</td>
                        <td>再次购买</td>
                    </tr>
                    <% while(sqlRst.next()){//取得下一条记录 %>
                    <tr>
                        <td><%=sqlRst.getString("productNo")%></td>
                        <td><%=sqlRst.getString("productName")%></td>
                        <td><%=sqlRst.getString("serialNo")%></td>
                        <td><%=sqlRst.getString("unitPrice")%></td>
                        <td><%=sqlRst.getString("quantityOnHand")%></td>
                        <td><%=sqlRst.getString("reorderLevel")%></td>
                        <td><%=sqlRst.getString("reorderQuantity")%></td>
                        <td><%=sqlRst.getString("reorderLeadTime")%></td>
                        <td><%=sqlRst.getString("categoryNo")%></td>
                        <td><a href="emp-purchase-add.jsp?productNo=<%=sqlRst.getString("productNo")%>">再次购买</a></td>
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
