package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.model.User;
import homework.model.Enrollment;
import homework.model.Exercise;
import homework.util.HibernateUtil;

/**
 *
 * @author ibranovic
 */
public class ConfirmEnrollmentCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
         String exerciseId = (String) request.getParameter("id");
         User logged = (User) request.getSession().getAttribute("korisnik");
         Enrollment enrollment = Enrollment.findForUserAndExercise(logged, HibernateUtil.load(Exercise.class, exerciseId));
         enrollment.setAccepted(true);
         HibernateUtil.saveOrUpdate(enrollment);
         return new EnrollmentListCommand().execute(request);
    }
    
}
