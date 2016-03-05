package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class emp_002dconfirm_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("        <title>确定交易</title>\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/style.css\" />\n");
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
        
      out.write("\n");
      out.write("        <div class=\"wrapper\">\n");
      out.write("            <div class=\"header\">\n");
      out.write("                <h1>确定交易</h1>\n");
      out.write("                <h2>你有权对以下的购买订单确认或删除，确定就添加到交易表中。</h2>\n");
      out.write("                <div class=\"trigger\">\n");
      out.write("                    你好，<a>");
      out.print(employee);
      out.write("</a>\n");
      out.write("                </div>\n");
      out.write("                <ul class=\"nav\">\n");
      out.write("                    <li><a href=\"emp-confirm.jsp\">确定交易</a></li>\n");
      out.write("                    <li><a href=\"emp-product-add.jsp\">增加产品</a></li>\n");
      out.write("                </ul>\n");
      out.write("            </div>\n");
      out.write("            ");

                java.sql.Connection conn = null;
                java.lang.String strConn;
                java.sql.Statement sqlStmt = null;//语句对象
                java.sql.Statement sqlStmt1 = null;//语句对象
                java.sql.ResultSet sqlRst = null;//结果集对象
                java.sql.ResultSet sqlRst1 = null;//结果集对象
                try{
                    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver").newInstance();
                    conn = java.sql.DriverManager.getConnection("jdbc:sqlserver://localhost:1433;DatabaseName=库存控制","sa","bizhongbio");
                    sqlStmt = conn.createStatement();
                    //执行SQL语句
                    String sqlQuery = "SELECT * FROM PurchaseOrder";
                    sqlRst = sqlStmt.executeQuery(sqlQuery);
            
      out.write("\n");
      out.write("            <div class=\"content\">\n");
      out.write("                <h2>购买订购表</h2>\n");
      out.write("                <table>\n");
      out.write("                    <tr>\n");
      out.write("                        <td>购买订单代码</td>\n");
      out.write("                        <td>购买订单描述</td>\n");
      out.write("                        <td>订货日期</td>\n");
      out.write("                        <td>交货日期</td>\n");
      out.write("                        <td>发货日期</td>\n");
      out.write("                        <td>货运费</td>\n");
      out.write("                        <td>供应商代码</td>\n");
      out.write("                        <td>工作人员代码</td>\n");
      out.write("                        <td>是否交易</td>\n");
      out.write("                        <td>是否删除</td>\n");
      out.write("                    </tr>\n");
      out.write("                    ");
 while(sqlRst.next()){//取得下一条记录 
      out.write("\n");
      out.write("                    <tr>\n");
      out.write("                        <td>");
      out.print(sqlRst.getString("purchaseOrderNo"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst.getString("purchaseOrderDescription"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst.getString("orderDate"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst.getString("dateRequired"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst.getString("shippedDate"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst.getString("freightCharge"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst.getString("supplierNo"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst.getString("employeeNo"));
      out.write("</td>\n");
      out.write("                        <td><a href=\"emp-confirm-place.jsp?purchaseOrderNo=");
      out.print(sqlRst.getString("purchaseOrderNo"));
      out.write("&purchaseProductNo=");
      out.print(sqlRst.getString("purchaseProductNo"));
      out.write("\">交易</a></td>\n");
      out.write("                        <td><a href=\"emp-confirm-place.jsp?purchaseOrderNo=");
      out.print(sqlRst.getString("purchaseOrderNo"));
      out.write("\">删除</a></td>\n");
      out.write("                    </tr>\n");
      out.write("                    ");
 
                    }
                    sqlStmt1 = conn.createStatement();
                    //执行SQL语句
                    String sqlQuery1 = "SELECT * FROM [Transaction]";
                    sqlRst1 = sqlStmt.executeQuery(sqlQuery1);
                    
      out.write("\n");
      out.write("                </table>\n");
      out.write("                <h2>交易表</h2>\n");
      out.write("                <table>\n");
      out.write("                    <tr>\n");
      out.write("                        <td>交易代码</td>\n");
      out.write("                        <td>交易日期</td>\n");
      out.write("                        <td>交易说明</td>\n");
      out.write("                        <td>单价</td>\n");
      out.write("                        <td>单位订单</td>\n");
      out.write("                        <td>收到订单</td>\n");
      out.write("                        <td>销量</td>\n");
      out.write("                        <td>单位损耗</td>\n");
      out.write("                        <td>总价</td>\n");
      out.write("                        <td>产品代码</td>\n");
      out.write("                        <td>购买订单代码</td>\n");
      out.write("                    </tr>\n");
      out.write("                    ");
 while(sqlRst1.next()){//取得下一条记录 
      out.write("\n");
      out.write("                    <tr>\n");
      out.write("                        <td>");
      out.print(sqlRst1.getString("transactionNo"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst1.getString("transactionDate"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst1.getString("transactionDescription"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst1.getString("unitPrice"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst1.getString("unitsOrdered"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst1.getString("unitsReceived"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst1.getString("unitsSold"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst1.getString("unitsWastage"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst1.getString("totalPrice"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst1.getString("productNo"));
      out.write("</td>\n");
      out.write("                        <td>");
      out.print(sqlRst1.getString("purchaseOrderNo"));
      out.write("</td>\n");
      out.write("                    </tr>\n");
      out.write("                    ");
 } 
      out.write("\n");
      out.write("                </table>\n");
      out.write("                ");

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
                
      out.write("\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
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
