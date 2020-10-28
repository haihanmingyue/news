package dao;

import model.News;
import model.User;

import java.util.List;
import java.util.Map;

public interface NewsDao {
    public List<News> allNews(Map<String,String> m);
    public int addNews(News news);
    public int upNewsMsg(News news);
    public int deleteNews(int id);

}
