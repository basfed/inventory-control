<%-- 
    Document   : emp-check
    Created on : 2015-12-20, 19:46:46
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
            String employeeNo = request.getParameter("employeeno"); 
            String empPassword = request.getParameter("emppassword");
            String save = request.getParameter("save");
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            java.sql.ResultSet sqlRst = null;//结果集对象
            try{
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();//加载数据库驱动类
                conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                sqlStmt = conn.createStatement();
                //执行SQL语句
                if((employeeNo!=null&&employeeNo.length()!=0)&&(empPassword!=null&&empPassword.length()!=0)){
                    String sqlQuery = "SELECT * FROM Employee";
                    sqlRst = sqlStmt.executeQuery(sqlQuery);
                    while(sqlRst.next()){//取得下一条记录
                        String dbEmployeeNo = sqlRst.getString("employeeNo");
                        String dbempPassword = sqlRst.getString("empPassword");
                        String dbPosition = sqlRst.getString("position");
                        if(dbEmployeeNo.equals(employeeNo)&&dbempPassword.equals(empPassword)){
                            session.setAttribute("EMPLOYEE_NO",dbEmployeeNo);
                            session.setAttribute("EMPLOYEE_POSITION",dbPosition);
                            employeeNo = java.net.URLEncoder.encode(employeeNo,"UTF-8");//保存cookie之前把值编码
                            empPassword = java.net.URLEncoder.encode(empPassword,"UTF-8");
                            Cookie cookie_employeeno = new Cookie("EMPLOYEENO",employeeNo);//生成cookie对象
                            Cookie cookie_emppassword = new Cookie("EMPPASSWORD",empPassword);
                            if(save != null && save.equals("yes")){
                                cookie_employeeno.setPath(request.getContextPath());
                                cookie_emppassword.setPath(request.getContextPath());
                                cookie_employeeno.setMaxAge(7*24*60*60);//设置Cookie的过期时间
                                cookie_emppassword.setMaxAge(7*24*60*60);
                                response.addCookie(cookie_employeeno);
                                response.addCookie(cookie_emppassword);
                            }else{//设置一个负值，Cookie不被存储，在用户退出浏览器后马上过期
                                cookie_employeeno.setMaxAge(-1);
                                cookie_emppassword.setMaxAge(-1);
                            }
                            if(dbPosition.equals("购买订单人员")){
                                response.sendRedirect("emp-purchase.jsp");
                            }else if(dbPosition.equals("确定交易人员")){
                                response.sendRedirect("emp-confirm.jsp");
                            }else if(dbPosition.equals("验收货物人员")){
                                response.sendRedirect("emp-accept.jsp");
                            }else if(dbPosition.equals("发货人员")){
                                response.sendRedirect("emp-deliver.jsp");
                            }
                            break;
                        }
                    }
                }
                response.sendRedirect("emp-login.jsp");
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
