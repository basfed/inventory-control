<%-- 
    Document   : user-purchase
    Created on : 2015-12-24, 9:46:15
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>客户购买</title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            session = request.getSession(true);//获取会话对象
            String userName = (String)session.getAttribute("USER_NAME");//从会话中获取客户名
            if(userName==null){
                response.sendRedirect("index.jsp");
            }
        %>
        <div class="wrapper">
            <div class="header">
                <h1>客户购买</h1>
                <h2>选择你想要购买的商品</h2>
                <div class="trigger">
                    你好，<a><%=userName%></a>
                </div>
                <ul class="nav">
                    <li><a href="user-purchase.jsp">客户购买</a></li>
                    <li><a href="user-purchase-history.jsp">历史购买</a></li>
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
                        <td>产品分类代码</td>
                        <td>是否购买</td>
                    </tr>
                    <% while(sqlRst.next()){//取得下一条记录 %>
                    <tr>
                        <td><%=sqlRst.getString("productNo")%></td>
                        <td><%=sqlRst.getString("productName")%></td>
                        <td><%=sqlRst.getString("serialNo")%></td>
                        <td><%=sqlRst.getString("unitPrice")%></td>
                        <td><%=sqlRst.getString("quantityOnHand")%></td>
                        <td><%=sqlRst.getString("categoryNo")%></td>
                        <td><a href="user-purchase-add.jsp?productNo=<%=sqlRst.getString("productNo")%>">购买</a></td>
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
