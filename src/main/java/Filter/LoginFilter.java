package Filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "LoginFilter",urlPatterns = {"/*"} )
public class LoginFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        Object o = request.getSession().getAttribute("user");
        String path = request.getServletPath();
        System.out.println(path);
        if( o!=null || path.equals("/index.jsp") || path.equals("/user/login") || path.equals("/shouye.jsp") || path.equals("/index") || path.equals("/user/lgout")  || path.equals("/login.html")  || path.equals("/user/toLogin")){
            chain.doFilter(req, resp);
        }else if(path.contains(".css") || (path.endsWith(".js"))|| path.contains(".png")|| path.contains(".jpg")){
            chain.doFilter(req, resp);
        }
        else {
            response.getWriter().println("<h1 style='margin-left:50px;margin-top:50px'>您还未登录，请先登录</h1>");
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
