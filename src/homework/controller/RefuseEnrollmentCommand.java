package homework.controller;

import homework.model.Enrollment;
import homework.model.Exercise;
import homework.model.User;
import homework.util.HibernateUtil;
import homework.util.Validate;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ibranovic
 */
public class RefuseEnrollmentCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        String exerciseId = (String) request.getParameter("id");
        User logged = (User) request.getSession().getAttribute("korisnik");
        
        String comment = request.getParameter("komentar");
        
        if (Validate.exists(comment)) {
            Enrollment enrollment = new Enrollment();
            enrollment.setAccepted(true);
            enrollment.setExercise(HibernateUtil.load(Exercise.class, exerciseId));
            enrollment.setUser(logged);
            enrollment.setComment(comment);
            HibernateUtil.saveOrUpdate(enrollment);
        }  
        return new EnrollmentListCommand().execute(request);
    }
}
