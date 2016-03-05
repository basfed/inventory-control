<%-- 
    Document   : emp-accept-make
    Created on : 2015-12-23, 17:44:34
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>填写验收产品</title>
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
                <h1>填写验收产品</h1>
                <h2>认真填写验收产品信息</h2>
                <div class="trigger">
                    你好，<a><%=employee%></a>
                </div>
                <ul class="nav">
                    <li><a href="emp-confirm.jsp">验收货物</a></li>
                </ul>
            </div>
            <%
                String transactionNo = request.getParameter("transactionNo");
                java.sql.Connection conn = null;
                java.lang.String strConn;
                java.sql.Statement sqlStmt = null;//语句对象
                java.sql.ResultSet sqlRst = null;//结果集对象
                try{
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
                    conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                    sqlStmt = conn.createStatement();
                    //执行SQL语句
                    String sqlQuery = "SELECT * FROM [Transaction] WHERE transactionNo="+transactionNo;
                    sqlRst = sqlStmt.executeQuery(sqlQuery);
                    while(sqlRst.next()){//取得下一条记录
            %>
            <div class="content">
                <h2>请认真填写验收产品信息</h2>
                <form class="form-purchase" method="POST" action="emp-accept-make.jsp">
                    <p>交易代码：<%=transactionNo%></p>
                    <p>单位订单：<%=sqlRst.getString("unitsOrdered")%></p>
                    <p>收到订单</p>
                    <input type="text" name="unitsReceived" placeholder="收到订单">
                    <p>销量</p>
                    <input type="text" name="unitsSold" placeholder="销量">
                    <p>单位损耗</p>
                    <input type="text" name="unitsWastage" placeholder="单位损耗">
                    <input type="hidden" name="transactionNo" value="<%=transactionNo%>">
                    <input type="hidden" name="unitPrice" value="<%=sqlRst.getString("unitPrice")%>">
                    <input type="hidden" name="unitsOrdered" value="<%=sqlRst.getString("unitsOrdered")%>">
                    <input type="hidden" name="productNo" value="<%=sqlRst.getString("productNo")%>">
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
                    <input type="submit" value="提交">
                </form>
            </div>
        </div>
    </body>
</html>
