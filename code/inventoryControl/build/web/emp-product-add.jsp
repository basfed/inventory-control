<%-- 
    Document   : emp-product-add
    Created on : 2015-12-23, 13:06:32
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>增加产品</title>
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
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            java.sql.ResultSet sqlRst = null;//结果集对象
            try{
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
                conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                sqlStmt = conn.createStatement();
                //执行SQL语句
                String sqlQuery = "SELECT * FROM ProductCategory";
                sqlRst = sqlStmt.executeQuery(sqlQuery);
        %>
        <div class="wrapper">
            <div class="header">
                <h1>增加产品</h1>
                <h2>增加产品到库存中</h2>
                <div class="trigger">
                    你好，<a><%=employee%></a>
                </div>
                <ul class="nav">
                    <li><a href="emp-confirm.jsp">确定交易</a></li>
                    <li><a href="emp-product-add.jsp">增加产品</a></li>
                </ul>
            </div>
            <div class="content">
                <h2>请认真填写增加的产品信息</h2>
                <form class="form-purchase" method="POST" action="emp-product-place.jsp">
                    <p>产品名称</p>
                    <input type="text" name="productName" placeholder="产品名称">
                    <p>产品编号</p>
                    <input type="text" name="serialNo" placeholder="产品编号">
                    <p>产品单价</p>
                    <input type="text" name="unitPrice" placeholder="产品单价">
                    <p>产品现存数量</p>
                    <input type="number" name="quantityOnHand" placeholder="产品现存数量">
                    <p>订货点水平</p>
                    <select name="reorderLevel">
                        <option value="低">低</option>
                        <option value="中">中</option>
                        <option value="高">高</option>
                    </select>
                    <p>再订购数量</p>
                    <input type="number" name="reorderQuantity" placeholder="再订购数量">
                    <p>订货提前期</p>
                    <input type="date" name="reorderLeadTime" placeholder="订货提前期">
                    <p>产品分类代码</p>
                    <select name="categoryNo">
                        <% while(sqlRst.next()){ %>
                        <option value="<%=sqlRst.getString("categoryNo")%>"><%=sqlRst.getString("categoryDescription")%></option>
                        <% } %>
                    </select>
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
                    <input type="submit" value="增加产品">
                </form>
            </div>
        </div>
    </body>
</html>
