package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.model.User;
import homework.util.HibernateUtil;
import homework.util.Validate;

/**
 *
 * @author ibranovic
 */
public class AssignCoursesCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        String userId = request.getParameter("id");
        String[] courses = request.getParameterValues("predmeti");

        User logged = (User) request.getSession().getAttribute("korisnik");
        boolean validParams = (courses != null);

        User operatingUser;
        
        if (validParams) {
            
            if (logged.isAdmin()) {
                
                if (Validate.isInteger(userId)) {
                    //korisnik kome admin dodeljuje predmete
                    operatingUser = HibernateUtil.findByPrimaryKey(User.class, userId);
                } else {
                    CommandsUtils.attachI18nMessage(request,"ENTER_DATA");
                    return "assigncourses";
                }
                
            } else {
                //demonstrator bira predmete za sebe
                operatingUser = logged;
            }
            
            operatingUser.clearCourses();
            for(String courseId : courses)
                operatingUser.addCourse(courseId);
            
            HibernateUtil.saveOrUpdate(operatingUser);
            
            return CommandsUtils.homePageSwitch(logged, request);

        } else {
            CommandsUtils.attachI18nMessage(request,"ENTER_ALL");
            return "assigncourses";
        }
    }
}
