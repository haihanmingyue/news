package Filter;

import model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "UserManagerFilter",urlPatterns = {"/user/*"})
public class UserManagerFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        Object o = request.getSession().getAttribute("user");
        User u = (User) o;
        String path = request.getServletPath();
        if( (o!=null && u.getAuth().equals("admin")) || path.equals("/user/toLogin") || path.equals("/user/login") || path.equals("/user/lgout")){
            chain.doFilter(req, resp);
        }
        else {
            response.getWriter().write("<h1 style='margin-left:50px;margin-top:50px'>您不是管理员，无法进行用户管理操作</h1>");
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
