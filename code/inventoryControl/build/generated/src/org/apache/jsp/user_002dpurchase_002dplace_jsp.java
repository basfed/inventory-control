package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class user_002dpurchase_002dplace_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>提交购买订单</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");

            request.setCharacterEncoding("UTF-8");
            session = request.getSession(true);//获取会话对象
            String userNo = (String)session.getAttribute("USER_NO");//从会话中获取客户代码
            String userName = (String)session.getAttribute("USER_NAME");//从会话中获取客户名
            if(userName==null){
                response.sendRedirect("index.jsp");
            }
            String userOrderDescription = request.getParameter("userOrderDescription"); 
            int orderQuantity = Integer.parseInt(request.getParameter("orderQuantity"));
            String productNo = request.getParameter("productno");
            float unitPrice = Float.parseFloat(request.getParameter("unitPrice"));
            int productNoQuantityOnHand = Integer.parseInt(request.getParameter("productNoQuantityOnHand"));
            float totalPrice = orderQuantity*unitPrice;
            java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM--dd HH:mm:ss");
            java.util.Date currentTime = new java.util.Date();//得到当前系统时间
            String str_date1 = formatter.format(currentTime);//将日期时间格式化
            String str_date2 = currentTime.toString();//将Date型日期时间转换成字符串形式
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            java.sql.Statement sqlStmt1 = null;//语句对象
            java.sql.Statement sqlStmt2 = null;//语句对象
            java.sql.ResultSet sqlRst = null;//结果集对象
            try{
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
                conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                sqlStmt = conn.createStatement();
                //执行SQL语句
                String condition = "SELECT userAddress,userTelNo FROM [User] WHERE userNo=" + userNo;
                sqlRst = sqlStmt.executeQuery(condition);
                while(sqlRst.next()){//取得下一条记录
                    String userAddress = sqlRst.getString("userAddress");
                    String userTelNo = sqlRst.getString("userTelNo");
                    String userOrderStatus = "已付款";
                    sqlStmt1 =conn.createStatement();
                    //执行SQL语句
                    String sql = "INSERT INTO UserOrder(userNo,userName,userOrderDate,userOrderDescription,userAddress,userTelNo,productNo,orderQuantity,totalPrice,userOrderStatus) VALUES('"+userNo+"','"+userName+"','"+str_date2+"','"+userOrderDescription+"','"+userAddress+"','"+userTelNo+"','"+productNo+"','"+orderQuantity+"','"+totalPrice+"','"+userOrderStatus+"')"; 
                    sqlStmt1.executeUpdate(sql);
                    productNoQuantityOnHand -= orderQuantity;
                    String reorderLevel = "";
                    if(productNoQuantityOnHand > 5000){
                        reorderLevel = "低";
                    }else if(productNoQuantityOnHand > 1000){
                        reorderLevel = "中";
                    }else{
                        reorderLevel = "高";
                    }
                    sqlStmt2 =conn.createStatement();
                    //执行SQL语句
                    String sql1 = "UPDATE Product SET quantityOnHand='"+productNoQuantityOnHand+"',reorderLevel='"+reorderLevel+"',reorderQuantity='"+orderQuantity+"' WHERE productNo="+productNo;
                    sqlStmt2.executeUpdate(sql1);
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
            response.sendRedirect("user-purchase.jsp");
        
      out.write("\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
