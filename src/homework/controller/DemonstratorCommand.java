package homework.controller;

import homework.model.Course;
import javax.servlet.http.HttpServletRequest;
import homework.model.User;
import homework.util.HibernateUtil;

/**
 *
 * @author ibranovic
 */
public class DemonstratorCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {  
        //lista svih demonstratora
        request.setAttribute("lista", User.findDemonstrators());
        request.setAttribute("svipredmeti", HibernateUtil.findAll(Course.class));
        return "userlist";
    }
    
}
