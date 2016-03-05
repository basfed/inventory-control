<%-- 
    Document   : accept
    Created on : 2015-12-20, 20:11:41
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>验收货物</title>
        <link rel="stylesheet" href="css/style.css" />
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
        %>
        <div class="wrapper">
            <div class="header">
                <h1>验收货物</h1>
                <h2>你有权对【交易表】的再购买产品验收入库，相应更新表。</h2>
                <div class="trigger">
                    你好，<a><%=employee%></a>
                </div>
                <ul class="nav">
                    <li><a href="emp-accept.jsp">验收货物</a></li>
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
                    String sqlQuery = "SELECT * FROM [Transaction]";
                    sqlRst = sqlStmt.executeQuery(sqlQuery);
            %>
            <div class="content">
                <h2>交易表</h2>
                <table>
                    <tr>
                        <td>交易代码</td>
                        <td>交易日期</td>
                        <td>交易说明</td>
                        <td>单价</td>
                        <td>单位订单</td>
                        <td>总价</td>
                        <td>产品代码</td>
                        <td>购买订单代码</td>
                        <td>确定验收</td>
                    </tr>
                    <% while(sqlRst.next()){//取得下一条记录 %>
                    <tr>
                        <td><%=sqlRst.getString("transactionNo")%></td>
                        <td><%=sqlRst.getString("transactionDate")%></td>
                        <td><%=sqlRst.getString("transactionDescription")%></td>
                        <td><%=sqlRst.getString("unitPrice")%></td>
                        <td><%=sqlRst.getString("unitsOrdered")%></td>
                        <td><%=sqlRst.getString("totalPrice")%></td>
                        <td><%=sqlRst.getString("productNo")%></td>
                        <td><%=sqlRst.getString("purchaseOrderNo")%></td>
                        <% if(sqlRst.getString("unitsReceived")==null){ %>
                            <td><a href="emp-accept-place.jsp?transactionNo=<%=sqlRst.getString("transactionNo")%>">验收</a></td>
                        <% }else{ %>
                            <td>验收</td>
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
