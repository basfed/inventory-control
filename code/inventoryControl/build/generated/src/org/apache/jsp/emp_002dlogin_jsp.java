package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class emp_002dlogin_jsp extends org.apache.jasper.runtime.HttpJspBase
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
      out.write("        <title>工作人员登录</title>\n");
      out.write("        <link rel=\"stylesheet\" href=\"css/style.css\" />\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        ");

            String employeeNo = "";
            String empPassword = "";
            Cookie[] cookies = request.getCookies();//获取请求相关的cookie
            if(cookies != null){
                for(int i=0;i<cookies.length;i++){
                    if(cookies[i].getName().equals("EMPLOYEENO")){
                        employeeNo = cookies[i].getValue();
                        employeeNo = java.net.URLDecoder.decode(employeeNo,"UTF-8");//取cookie值时解码
                    }
                    if(cookies[i].getName().equals("EMPPASSWORD")){
                        empPassword = cookies[i].getValue();
                        empPassword = java.net.URLDecoder.decode(empPassword,"UTF-8");
                    }
                }
            }
        
      out.write("\n");
      out.write("        <div class=\"wrapper\">\n");
      out.write("            <div class=\"header\">\n");
      out.write("                <h1 class=\"title\">工作人员登录</h1>\n");
      out.write("                <div class=\"trigger\">\n");
      out.write("                    <a href=\"emp-login.jsp\" style=\"color: #333;\">登录</a>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("            <form class=\"form-login\" method=\"POST\" action=\"emp-login-check.jsp\">\n");
      out.write("                <input type=\"text\" name=\"employeeno\" value=\"");
      out.print(employeeNo);
      out.write("\" placeholder=\"工作人员编号\">\n");
      out.write("                <input type=\"password\" name=\"emppassword\" value=\"");
      out.print(empPassword);
      out.write("\" placeholder=\"密码\">\n");
      out.write("                <input type=\"checkbox\" name=\"save\" value=\"yes\" checked>\n");
      out.write("                <label>记住登录状态</label>\n");
      out.write("                <input type=\"submit\" name=\"login\" value=\"登录\">\n");
      out.write("                <input type=\"reset\" name=\"reset\" value=\"重置\">\n");
      out.write("            </form>\n");
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
