package homework.controller;

import homework.model.Course;
import homework.model.User;
import homework.util.HibernateUtil;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ibranovic
 */
public class EditCoursesCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        request.setAttribute("predmeti", HibernateUtil.findAll(Course.class));
        request.setAttribute("nastavnici", User.findInstructors());
        return "assigncourses"; 
    }
    
}
