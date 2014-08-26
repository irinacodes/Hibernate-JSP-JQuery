package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.model.User;

/**
 *
 * @author ibranovic
 */
public class InstructorCoursesCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
       User instructor = (User) request.getSession().getAttribute("korisnik");
       request.setAttribute("lista", instructor.getCourses());
       return "courselist";
    }
    
}
