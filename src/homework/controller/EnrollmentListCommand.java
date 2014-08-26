package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.model.User;
import homework.model.Exercise;

/**
 *
 * @author ibranovic
 */
public class EnrollmentListCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        User demonstrator = (User) request.getSession().getAttribute("korisnik");
        request.setAttribute("lista", Exercise.callsForDemonstrator(demonstrator));
        return "exerciselist";
    }
    
}
