package dao;

import model.User;

import java.util.List;
import java.util.Map;

public interface UserDao {
    public List<User> allUser(Map<String,String> map);
    public int addUser(User user);
    public int UserCount(String account);
    public int upUserMsg(User user);
    public int deleteUser(int id);
    public int login(User user);
    public User UserMsg(User user);
}
