package Filter;

import model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(filterName = "NewsManagerFilter",urlPatterns = {"/news/addnews"})
public class NewsManagerFilter implements Filter {
    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;
        String auth = req.getParameter("type");
        Object o = request.getSession().getAttribute("user");
        User u = (User) o;
        System.out.println(auth);
        if( u.getAuth().equals("admin") || u.getAuth().equals(auth) ){
            chain.doFilter(req, resp);
        }
        else {
            response.getWriter().write("3");
        }
    }

    public void init(FilterConfig config) throws ServletException {

    }

}
