package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class emp_002dconfirm_002dplace_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("        <title>生成交易表</title>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");

            request.setCharacterEncoding("UTF-8");
            session = request.getSession(true);//获取会话对象
            String employee = (String)session.getAttribute("EMPLOYEE_NO");//从会话中获取工作人员代码
            String empPosition = (String)session.getAttribute("EMPLOYEE_POSITION");//从会话中获取职位
            if(employee==null || !(empPosition.equals("确定交易人员"))){
                response.sendRedirect("index.jsp");
            }
            String purchaseOrderNo = request.getParameter("purchaseOrderNo");
            String purchaseProductNo = request.getParameter("purchaseProductNo");//删除，其值为null
            java.sql.Connection conn = null;
            java.lang.String strConn;
            java.sql.Statement sqlStmt = null;//语句对象
            java.sql.Statement sqlStmt1=null;//语句对象
            java.sql.Statement sqlStmt2=null;//语句对象
            java.sql.ResultSet sqlRst = null;//结果集对象
            java.sql.ResultSet sqlRst1 = null;//结果集对象
            try{
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
                conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                sqlStmt = conn.createStatement();
                //执行SQL语句
                if(purchaseProductNo!=null){
                    String condition = "SELECT unitPrice,reorderQuantity FROM Product WHERE ProductNo=" + purchaseProductNo;
                    sqlRst = sqlStmt.executeQuery(condition);
                    while(sqlRst.next()){//取得下一条记录
                        float unitPrice = sqlRst.getFloat("unitPrice");
                        int unitsOrdered = sqlRst.getInt("reorderQuantity");
                        String condition1 = "SELECT purchaseOrderNo,purchaseOrderDescription,dateRequired FROM PurchaseOrder WHERE purchaseOrderNo="+ purchaseOrderNo;
                        sqlStmt1=conn.createStatement();
                        sqlRst1 = sqlStmt1.executeQuery(condition1);
                        while(sqlRst1.next()){//取得下一条记录
                            String transactionDate = sqlRst1.getString("dateRequired");
                            String transactionDescription = sqlRst1.getString("purchaseOrderDescription");
                            sqlStmt2=conn.createStatement();
                            String sql = "INSERT INTO [Transaction](transactionDate,transactionDescription,unitPrice,unitsOrdered,totalPrice,productNo,purchaseOrderNo) VALUES('"+transactionDate+"','"+transactionDescription+"','"+unitPrice+"','"+unitsOrdered+"','"+(unitPrice*unitsOrdered)+"','"+purchaseProductNo+"','"+purchaseOrderNo+"')"; 
                            sqlStmt2.executeUpdate(sql);
                        }
                    }
                }else{
                    String condition = "DELETE FROM PurchaseOrder WHERE purchaseOrderNo=" + purchaseOrderNo;
                    sqlStmt.executeUpdate(condition);
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
            response.sendRedirect("emp-confirm.jsp");
        
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
