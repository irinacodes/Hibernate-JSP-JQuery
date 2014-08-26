package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.model.Course;
import homework.util.HibernateUtil;
import homework.util.Validate;

/**
 *
 * @author ibranovic
 */
public class CourseCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        String courseId = request.getParameter("predmetid");
        String code = request.getParameter("sifra");
        String name = request.getParameter("naziv");
        String semester = request.getParameter("semestar");
        String schoolYear = request.getParameter("skgod");

        boolean validParams = Validate.exists(code) && Validate.exists(name)
                && Validate.isInteger(semester) && Validate.isInteger(schoolYear);

        if (validParams) {
            Course course;
            
            if (Validate.exists(courseId)) {
                //edit
                course = HibernateUtil.findByPrimaryKey(Course.class, courseId);        
            } else {
                 //nov predmet
                course = new Course();   
            }
            
            course.setName(name);
            course.setCode(code);
            course.setSemester(semester);
            course.setSchoolYear(Integer.valueOf(schoolYear));
            HibernateUtil.saveOrUpdate(course);
            return new ListCommand(Course.class).execute(request);
        } else {
            CommandsUtils.attachI18nMessage(request,"ENTER_ALL");
            return "course";
        }
    }
}
