<%-- 
    Document   : check
    Created on : 2015-12-20, 15:32:40
    Author     : bizho
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>验证登录信息</title>
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            String userName = request.getParameter("username"); 
            String password = request.getParameter("password");
            String save = request.getParameter("save");
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            java.sql.ResultSet sqlRst = null;//结果集对象
            try{
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
                conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                sqlStmt = conn.createStatement();
                //执行SQL语句
                if((userName!=null&&userName.length()!=0)&&(password!=null&&password.length()!=0)){
                    String sqlQuery = "SELECT * FROM [User]";
                    sqlRst = sqlStmt.executeQuery(sqlQuery);
                    while(sqlRst.next()){//取得下一条记录
                        String dbUserNo = sqlRst.getString("userNo");
                        String dbUserName = sqlRst.getString("userName");
                        String dbUserPassword = sqlRst.getString("userPassword");
                        if(dbUserName.equals(userName)&&dbUserPassword.equals(password)){
                            session.setAttribute("USER_NO",dbUserNo);//将客户代码存入会话
                            session.setAttribute("USER_NAME",dbUserName);//将客户名存入会话
                            userName = java.net.URLEncoder.encode(userName,"UTF-8");//保存cookie之前把值编码
                            password = java.net.URLEncoder.encode(password,"UTF-8");
                            Cookie cookie_username = new Cookie("USERNAME",userName);//生成cookie对象
                            Cookie cookie_password = new Cookie("PASSWORD",password);
                            if(save != null && save.equals("yes")){
                                cookie_username.setPath(request.getContextPath());
                                cookie_password.setPath(request.getContextPath());
                                cookie_username.setMaxAge(7*24*60*60);//设置Cookie的过期时间
                                cookie_password.setMaxAge(7*24*60*60);
                                response.addCookie(cookie_username);
                                response.addCookie(cookie_password);
                            }else{//设置一个负值，Cookie不被存储，在用户退出浏览器后马上过期
                                cookie_username.setMaxAge(-1);
                                cookie_password.setMaxAge(-1);
                            }
                            response.sendRedirect("user-purchase.jsp");
                            break;
                        }
                    }
                }
                response.sendRedirect("user-login.jsp");
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
    </body>
</html>
