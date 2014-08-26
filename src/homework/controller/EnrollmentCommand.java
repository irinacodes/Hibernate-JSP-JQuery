package homework.controller;

import homework.model.*;
import homework.util.HibernateUtil;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ibranovic
 */
public class EnrollmentCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        String exerciseId = request.getParameter("id");
        String comment = request.getParameter("komentar");
        String activityId = request.getParameter("aktivnost");
        String userId = request.getParameter("korisnik");
        
        //prijava može samo da se pravi, ne i da se edituje
        Enrollment enrollment = new Enrollment();
        enrollment.setAccepted(false);
        enrollment.setExercise(HibernateUtil.load(Exercise.class, exerciseId));
        enrollment.setComment(comment);
        enrollment.setActivity(HibernateUtil.load(Activity.class, activityId));
        enrollment.setUser(HibernateUtil.load(User.class, userId));
        HibernateUtil.saveOrUpdate(enrollment);
        return new CallDemonstratorsCommand().execute(request);
    }
}
