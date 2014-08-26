package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.model.Exercise;
import homework.util.HibernateUtil;

/**
 *
 * @author ibranovic
 */
public class LockExerciseCommand implements Command {
    
    @Override
    public String execute(HttpServletRequest request) {
       String labId = (String) request.getParameter("id");
       Exercise exercise = HibernateUtil.load(Exercise.class, labId);
       exercise.setLocked(true);
       HibernateUtil.saveOrUpdate(exercise);
       return new InstructorExercisesCommand().execute(request);
    }
    
}
