package controller;

import com.alibaba.fastjson.JSON;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import dao.NewsDao;
import dao.UserDao;
import jdbc.Link;
import model.News;
import model.User;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
@RequestMapping("news")
public class NewsController {

    @RequestMapping("/newsindex")
    public String toNewsIndex(HttpServletRequest request){
        PageHelper.startPage(1, 7);
        Map<String,String> map = new HashMap<>();
        Page<News> page = (Page<News>) Link.getSqlSession().getMapper(NewsDao.class).allNews(map);
        PageInfo<News> info = page.toPageInfo();
        request.setAttribute("info", info);
        Link.closeSqlSession();
        return "/newsindex.jsp";
    }



    //添加用户
    @RequestMapping(value = "/addnews" , method = RequestMethod.POST)
    public void addUser(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String title = request.getParameter("title");
        String type = request.getParameter("type");
        String create = request.getParameter("date");
        String content = request.getParameter("html");
        String userid = request.getParameter("userid");
        News news = new News();
        news.setTitle(title);
        news.setCreateDate(create);
        news.setContent(content);
        news.setType(type);
        news.setUserId(userid);
        SqlSession s = Link.getSqlSession();
        int i = s.getMapper(NewsDao.class).addNews(news);
        System.out.println(i);
        if(i==1){
            s.commit();
            response.getWriter().write("1");
        }else {
            s.rollback();
            response.getWriter().write("2");
        }
        Link.closeSqlSession();
    }

    //分页
    @RequestMapping("/changepage")
    @ResponseBody
    public String changePage(HttpServletRequest request) throws IOException {
        request.getSession().removeAttribute("info");
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String type = request.getParameter("type");
        String userId = request.getParameter("userId");
        String createDate = request.getParameter("createDate");
        String pageNum = request.getParameter("pageNum");
        PageHelper.startPage(Integer.parseInt(pageNum), 7);
        Map<String,String> map = new HashMap<>();
        map.put("id",id);
        map.put("title",title);
        map.put("type",type);
        map.put("userId",userId);
        map.put("createDate",createDate);
        Page<News> page = (Page<News>) Link.getSqlSession().getMapper(NewsDao.class).allNews(map);
        PageInfo<News> info = page.toPageInfo();
        if(info.getSize()==0){
            PageHelper.startPage(Integer.parseInt(pageNum)-1, 7);
            page = (Page<News>) Link.getSqlSession().getMapper(NewsDao.class).allNews(map);
            info = page.toPageInfo();
        }
        return JSON.toJSONString(info);

        //其实也可以不弄返回值，改成void ，然后原样 response.getWriter().write(str)
    }

    //删除用户
    @RequestMapping(value = "/deletenews",method = RequestMethod.POST)
    public void deleteUser(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String id = request.getParameter("id");
        String userId = request.getParameter("userId");
        User u = (User) request.getSession().getAttribute("user");
        if(u.getAuth().equals("admin") || userId.trim().equals(u.getAccount())){

            SqlSession sqlSession = Link.getSqlSession();
            int i = sqlSession.getMapper(NewsDao.class).deleteNews(Integer.parseInt(id.trim()));
            if(i==1){
                sqlSession.commit();
                response.getWriter().write("1");
            }else {
                sqlSession.rollback();
                response.getWriter().write("2");
            }
            Link.closeSqlSession();
        }else {
            response.getWriter().write("no");
        }
    }

    //删除
    @RequestMapping(value = "/cgnewsmsg",method = RequestMethod.POST)
    public void changeNewsMsg(HttpServletResponse response,HttpServletRequest request) throws IOException {
        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String type = request.getParameter("type");
        String content = request.getParameter("html");

        News news = new News();
        news.setId(Integer.parseInt(id));
        news.setContent(content);
        news.setType(type);
        news.setTitle(title);
        SqlSession sqlSession = Link.getSqlSession();
        int i = sqlSession.getMapper(NewsDao.class).upNewsMsg(news);
        if(i == 1){
            sqlSession.commit();
            response.getWriter().write("1");
        }else {
            sqlSession.rollback();
            response.getWriter().write("2");
        }
        Link.closeSqlSession();
    }

    @RequestMapping(value = "/news")
    public void xxx(HttpServletResponse response,HttpServletRequest request) throws IOException {
        request.getSession().removeAttribute("info");
        String id = request.getParameter("id");
        Map<String,String> map = new HashMap<>();
        map.put("id",id);
        List<News> news = Link.getSqlSession().getMapper(NewsDao.class).allNews(map);
        response.getWriter().write("<div style='width:100%' align='center'><div class='col-xs-8'>"+news.get(0).getContent()+"</div></div>");
        Link.closeSqlSession();
    }

    @RequestMapping(value = "/openChangeNews")
    public String openChangeNews(HttpServletRequest request) throws ServletException, IOException {
        String id = request.getParameter("id");
        Map<String,String> map = new HashMap<>();
        map.put("id",id);
        List<News>list =  Link.getSqlSession().getMapper(NewsDao.class).allNews(map);
        String s = list.get(0).getContent();
        String dest = "";
        if (s!=null) {
            Pattern p = Pattern.compile("[\t\r\n]");
            Matcher m = p.matcher(s);
            dest = m.replaceAll("");
        }
        list.get(0).setContent("");
        list.get(0).setContent(dest);
        request.setAttribute("info", list.get(0));
        Link.closeSqlSession();
        return "/changeNews.jsp";
    }
}
