package homework.controller;

import homework.model.Course;
import homework.model.Title;
import javax.servlet.http.HttpServletRequest;
import homework.model.User;
import homework.util.HibernateUtil;

/**
 *
 * @author ibranovic
 */
public class FindUserCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        String name = request.getParameter("demoime");
        String surname = request.getParameter("demoprezime");
        String[] titleId = request.getParameterValues("zvanja");
        String[] courseId = request.getParameterValues("predmeti");
        
        User logged = (User) request.getSession().getAttribute("korisnik");
        boolean onlyDemonstrators = !logged.isAdmin() && logged.isInstructor();//nastavnici vide samo demonstratore

        request.setAttribute("lista", User.find(name, surname, titleId, courseId, onlyDemonstrators));
        request.setAttribute("svipredmeti", HibernateUtil.findAll(Course.class));
        request.setAttribute("svazvanja", HibernateUtil.findAll(Title.class));
        return "userlist";
    }
    
}
