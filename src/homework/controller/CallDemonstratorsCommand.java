package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.model.*;
import homework.util.HibernateUtil;

/**
 *
 * @author ibranovic
 */
public class CallDemonstratorsCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
         String exerciseId = (String) request.getParameter("id");
         Exercise exercise = HibernateUtil.load(Exercise.class, exerciseId);
         request.setAttribute("demo", User.getAvailableDemonstratorsForExercise(exercise));
         request.setAttribute("aktivnosti", HibernateUtil.findAll(Activity.class));
         request.setAttribute("vezba", exercise);
         return "calldemo";
    }
   
    
}
