<%-- 
    Document   : user-information-modify-place
    Created on : 2015-12-25, 11:15:57
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>客户信息修改操作</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            session = request.getSession(true);//获取会话对象
            String userNo = (String)session.getAttribute("USER_NO");//从会话中获取客户姓名
            String userName = (String)session.getAttribute("USER_NAME");//从会话中获取客户名
            String productNo = (String)session.getAttribute("PRODUCT_NO");//从会话中获取产品编号
            if(userName==null){
                response.sendRedirect("index.jsp");
            }
            String userAddress = request.getParameter("userAddress");
            String userTelNo = request.getParameter("userTelNo");
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            java.sql.ResultSet sqlRst = null;//结果集对象
            try{
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
                conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                sqlStmt = conn.createStatement();
                if((userAddress!=null&&userAddress.length()!=0)&&(userTelNo!=null&&userTelNo.length()!=0)){
                    //执行SQL语句
                    String sql = "UPDATE [User] SET userAddress='"+userAddress+"',userTelNo='"+userTelNo+"' WHERE userNo="+userNo;
                    sqlStmt.executeUpdate(sql);
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
            if(productNo!=null&&productNo.length()!=0){
                response.sendRedirect("user-purchase-add.jsp?productNo="+productNo);
            }else{
                response.sendRedirect("user-purchase.jsp");
            }
        %>
    </body>
</html>
