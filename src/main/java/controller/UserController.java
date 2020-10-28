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

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("user")
public class UserController {

    @RequestMapping("/userindex")
    public String toUserIndex(HttpServletRequest request){
        PageHelper.startPage(1, 10);
        Map<String,String> map = new HashMap<>();
        Page<User> page = (Page<User>) Link.getSqlSession().getMapper(UserDao.class).allUser(map);
        PageInfo<User> info = page.toPageInfo();
        request.setAttribute("info", info);
        Link.closeSqlSession();
        return "/userindex.jsp";
    }

//    跳转登录界面
    @RequestMapping("/toLogin")
    public String toLogin(){
        return "redirect:/login.html";
    }

//    ajax请求不需要返回页面，只需要得到response中的数据即可，所以方法签名为void即可
    //登录
    @RequestMapping(value = "/login" ,method = RequestMethod.POST)
    public void login(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User u = new User();
        u.setAccount(username);
        u.setPassword(password);
        int i;
        System.out.println("验证账号密码");
        i = Link.getSqlSession().getMapper(UserDao.class).login(u);
        Link.closeSqlSession();
        if(i==1) {
            User user = Link.getSqlSession().getMapper(UserDao.class).UserMsg(u);
            Link.closeSqlSession();
            request.getSession().setAttribute("user",user);
        }
        response.getWriter().write(i+"");
    }

    //退出
    @RequestMapping("/lgout")
    public String lgOut(HttpServletResponse response,HttpServletRequest request){
        request.getSession().invalidate();

        return "redirect:/index";
    }

    //添加用户首页
    @RequestMapping("/addUserIndex")
    public String toAddUserIndex(){
        return "redirect:/adduser.html";
    }

    //添加用户
    @RequestMapping(value = "/adduser" , method = RequestMethod.POST)
    public void addUser(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String account = request.getParameter("username");
        String password = request.getParameter("password");
        String auth = request.getParameter("auth");
        int i = Link.getSqlSession().getMapper(UserDao.class).UserCount(account);
        if (i == 0) {
            User user = new User();
            user.setAccount(account);
            user.setPassword(password);
            user.setAuth(auth);
            SqlSession sqlSession = Link.getSqlSession();
            int j = sqlSession.getMapper(UserDao.class).addUser(user);
            if (j == 1) {
                sqlSession.commit();
                response.getWriter().write(1 + "");
            } else {
                sqlSession.rollback();
                response.getWriter().write(3 + "");
            }
        } else {
            response.getWriter().write(2 + "");
        }
        Link.closeSqlSession();
    }

    //分页
    @RequestMapping(value = "/changepage",produces = "application/json;charset=utf-8")
    @ResponseBody
    public PageInfo<User> changePage(HttpServletRequest request) throws IOException {
        request.getSession().removeAttribute("info");
        String id = request.getParameter("id");
        String account = request.getParameter("account");
        String auth = request.getParameter("auth");
        String pageNum = request.getParameter("pageNum");
        PageHelper.startPage(Integer.parseInt(pageNum), 10);
        Map<String,String> map = new HashMap<>();
        map.put("id",id);
        map.put("account",account);
        map.put("auth",auth);
        Page<User> page = (Page<User>) Link.getSqlSession().getMapper(UserDao.class).allUser(map);
        PageInfo<User> info = page.toPageInfo();
        if(info.getSize()==0){
            PageHelper.startPage(Integer.parseInt(pageNum)-1, 10);
            page = (Page<User>) Link.getSqlSession().getMapper(UserDao.class).allUser(map);
            info = page.toPageInfo();
        }

//        String str = JSON.toJSONString(info);
//        Link.closeSqlSession();
//        response.getWriter().write(str);
        return info;

        //其实也可以不弄返回值，改成void ，然后原样 response.getWriter().write(str)
    }
    @RequestMapping(value="ajax4.do",produces = "application/json;charset=utf-8")
    @ResponseBody    //将返回的字符串作为响应内容
    public User ajax4() {
        User user = new User();
        user.setAccount("zhang3");
        return user;
    }

    //删除用户
    @RequestMapping(value = "/deleteuser",method = RequestMethod.POST)
    public void deleteUser(HttpServletRequest request,HttpServletResponse response) throws IOException {
        String id =request.getParameter("id");
        User u = (User) request.getSession().getAttribute("user");
        if(Integer.parseInt(id.trim()) == u.getId()){
            response.getWriter().write("no");
        }else {
            SqlSession sqlSession = Link.getSqlSession();
            int i = sqlSession.getMapper(UserDao.class).deleteUser(Integer.parseInt(id.trim()));
            if(i==1){
                sqlSession.commit();
                response.getWriter().write("1");
            }else {
                sqlSession.rollback();
                response.getWriter().write("2");
            }
            Link.closeSqlSession();
        }
    }

    //修改用户信息
    @RequestMapping(value = "/cgusermsg",method = RequestMethod.POST)
    public void changeUserMsg(HttpServletResponse response,HttpServletRequest request) throws IOException {
        String account =request.getParameter("account");
        String auth = request.getParameter("auth");
        User u = (User) request.getSession().getAttribute("user");
        if(account.equals(u.getAccount())){
            response.getWriter().write("no");
        }else {
            User user = new User();
            user.setAccount(account);
            user.setAuth(auth);
            SqlSession sqlSession = Link.getSqlSession();
            int i = sqlSession.getMapper(UserDao.class).upUserMsg(user);
            if(i == 1){
                sqlSession.commit();
                response.getWriter().write("1");
            }else {
                sqlSession.rollback();
                response.getWriter().write("2");
            }
            Link.closeSqlSession();
        }
    }
}
