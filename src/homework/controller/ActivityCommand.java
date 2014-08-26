package homework.controller;

import javax.servlet.http.HttpServletRequest;
import homework.model.Activity;
import homework.util.HibernateUtil;
import homework.util.Validate;

/**
 *
 * @author ibranovic
 */
public class ActivityCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
        String activityId = request.getParameter("aktivnostid");
        String name = request.getParameter("naziv");
        String coefficient = request.getParameter("koeficijent");

        boolean validParams = Validate.exists(name) && Validate.isDouble(coefficient);

        if (validParams) {
            Activity activity;
            
            if (Validate.exists(activityId)) {
                //edit
                activity = HibernateUtil.load(Activity.class, activityId);              
            } else {
               //kreiraj nov tip aktivnosti
                activity = new Activity();  
            }
            
            activity.setName(name);
            activity.setCoefficient(Double.valueOf(coefficient));
            HibernateUtil.saveOrUpdate(activity);
            //vrati se na listu svih aktivnosti
            return new ListCommand(Activity.class).execute(request);            
        } else {
           CommandsUtils.attachI18nMessage(request,"ENTER_ALL");
           return "activity"; 
        }
    }
}
