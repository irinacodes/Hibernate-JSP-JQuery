package homework.controller;

import homework.model.*;
import homework.util.HibernateUtil;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ibranovic
 */
public class UserListCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        request.setAttribute("lista", HibernateUtil.findAll(User.class));
        User logged = (User) request.getSession().getAttribute("korisnik");
        List<Course> courses;
        if (logged.isAdmin()) {
            courses = HibernateUtil.findAll(Course.class);
        } else {
            courses = new ArrayList<Course>(logged.getCourses());
        }
        request.setAttribute("svipredmeti", courses);
        request.setAttribute("svazvanja", HibernateUtil.findAll(Title.class));
        return "userlist";
    }
}
