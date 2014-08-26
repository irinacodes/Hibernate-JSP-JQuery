package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.model.User;
import homework.model.Exercise;

/**
 *
 * @author ibranovic
 */
public class InstructorExercisesCommand implements Command {
   

    @Override
    public String execute(HttpServletRequest request) {
        User instructor = (User) request.getSession().getAttribute("korisnik");
        request.setAttribute("lista", Exercise.listForInstructor(instructor));
        return "exerciselist";                
    }
}
