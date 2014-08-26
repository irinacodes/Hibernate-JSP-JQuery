package homework.controller;

import homework.model.Course;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import homework.model.Exercise;
import homework.util.HibernateUtil;
import homework.util.Validate;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author ibranovic
 */
public class ExerciseCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        String next;

        String id = request.getParameter("vezbaid");
        String name = request.getParameter("naziv");
        String date = request.getParameter("datum");
        String from = request.getParameter("vremeod");
        String to = request.getParameter("vremedo");
        String lab = request.getParameter("lab");
        String maxDemoNo = request.getParameter("maxdemo");
        String courseId = request.getParameter("predmetid");

        //provera parametara na serverskoj strani
        boolean validParams = Validate.exists(name) && Validate.isDate(date)
                && Validate.isTime(from) && Validate.isTime(to)
                && Validate.exists(lab) && Validate.isInteger(maxDemoNo)
                && Validate.isInteger(courseId);

        if (validParams) {
            try {
                Exercise exercise;
                if (id == null || id.isEmpty()) {
                    //nova lab vežba
                    exercise = new Exercise();
                    exercise.setLocked(false);  
                } else {
                   //edit
                    exercise = HibernateUtil.findByPrimaryKey(Exercise.class, id); 
                }
                exercise.setName(name);
                SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yyyy");
                exercise.setDate(sdf.parse(date));
                sdf = new SimpleDateFormat("HH:mm");
                exercise.setTimeFrom(sdf.parse(from));
                exercise.setTimeTo(sdf.parse(to));
                exercise.setLaboratory(lab);
                exercise.setMaxDemonstratorNo(Integer.valueOf(maxDemoNo));
                exercise.setCourse(HibernateUtil.load(Course.class, courseId));
                HibernateUtil.saveOrUpdate(exercise);
                next = new InstructorExercisesCommand().execute(request);
            } catch (ParseException ex) {
                request.setAttribute(RequestDispatcher.ERROR_EXCEPTION, ex);
                request.setAttribute(RequestDispatcher.ERROR_SERVLET_NAME, CommandServlet.class.getName());
                return "error";
            }
        } else {
            CommandsUtils.attachI18nMessage(request,"ENTER_ALL");
            request.setAttribute(name, to);
            next = new PrepareViewCommand(Exercise.class).execute(request);
        }
        return next;
    }
}
