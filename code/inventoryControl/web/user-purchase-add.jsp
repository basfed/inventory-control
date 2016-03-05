<%-- 
    Document   : user-purchase-add
    Created on : 2015-12-24, 10:30:50
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>填写客户购买订单</title>
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
                <h1>填写购买订单</h1>
                <h2>为了共同的利益，请您认真填写购买订单。</h2>
                <div class="trigger">
                    你好，<a><%=userName%></a>
                </div>
                <ul class="nav">
                    <li><a href="user-purchase.jsp">客户购买</a></li>
                    <li><a href="user-purchase-history.jsp">历史购买</a></li>
                </ul>
            </div>
            <%
                String productNo = request.getParameter("productNo");
                session.setAttribute("PRODUCT_NO",productNo);
                java.sql.Connection conn = null;
                java.lang.String strConn;
                java.sql.Statement sqlStmt = null;//语句对象
                java.sql.ResultSet sqlRst = null;//结果集对象
                try{
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
                    conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                    sqlStmt = conn.createStatement();
                    //执行SQL语句
                    String sqlQuery = "SELECT * FROM Product WHERE productNo=" + productNo;
                    sqlRst = sqlStmt.executeQuery(sqlQuery);
            %>
            <div class="content">
                <h2>以下是您要购买的产品信息</h2>
                <table>
                    <tr>
                        <td>产品代码</td>
                        <td>产品名称</td>
                        <td>产品编号</td>
                        <td>产品单价</td>
                        <td>现存数量</td>
                        <td>产品分类代码</td>
                    </tr>
                    <% while(sqlRst.next()){//取得下一条记录
                        String unitPrice = sqlRst.getString("unitPrice");
                        String productNoQuantityOnHand = sqlRst.getString("quantityOnHand");
                    %>
                    <tr>
                        <td><%=sqlRst.getString("productNo")%></td>
                        <td><%=sqlRst.getString("productName")%></td>
                        <td><%=sqlRst.getString("serialNo")%></td>
                        <td><%=sqlRst.getString("unitPrice")%></td>
                        <td><%=sqlRst.getString("quantityOnHand")%></td>
                        <td><%=sqlRst.getString("categoryNo")%></td>
                    </tr>
                </table>
                <h2>请认真填写【客户购买订单】</h2>
                <form class="form-purchase" method="POST" action="user-purchase-place.jsp">
                    <p>客户订单说明</p>
                    <textarea name="userOrderDescription" placeholder="客户订单说明"></textarea>
                    <p>订购数量</p>
                    <input type="text" name="orderQuantity" placeholder="订购数量">
                    <a href="user-information-modify.jsp">修改个人信息</a>
                    <input type="hidden" name="unitPrice" value="<%=unitPrice%>">
                    <input type="hidden" name="productNoQuantityOnHand" value="<%=productNoQuantityOnHand%>">
                <%
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
                %>
                    <input type="hidden" name="productno" value="<%=productNo%>">
                    <input type="submit" value="确定">
                </form>
            </div>
        </div>
    </body>
</html>
