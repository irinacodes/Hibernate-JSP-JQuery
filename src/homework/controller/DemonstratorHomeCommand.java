package homework.controller;

import homework.model.Activity;
import homework.model.Exercise;
import homework.model.User;
import homework.util.HibernateUtil;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

/**
 *
 * @author ibranovic
 */
public class DemonstratorHomeCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {
      String demonstratorId = request.getParameter("id");
      User logged = (User) request.getSession().getAttribute("korisnik");
      boolean editable = true;
      if(demonstratorId != null) {
         logged = HibernateUtil.findByPrimaryKey(User.class, demonstratorId);
         editable = false;
      } else {
          //reattach u obe sesije
          logged = HibernateUtil.findByPrimaryKey(User.class, logged.getId());
          request.getSession().setAttribute("korisnik", logged);
      }
      
      request.setAttribute("logged", logged);    
      request.setAttribute("editable", editable);
      
      /* zbog ograničenja koja nameće EL, moramo ovde napraviti mapu 
      [vezba : aktivnost prijavljenog demonstratora na toj vežbi] */
      
      Map<Exercise, Activity> exerciseActivities = new HashMap<Exercise, Activity>();
      for(Exercise exercise : Exercise.exerciseInCourseForDemonstrator(logged)) {
          exerciseActivities.put(exercise, Activity.ofDemonstratorOnExercise(exercise, logged));
      }
      request.setAttribute("mapavezbiaktivnosti", exerciseActivities);
      
      return "demohome";
    }    
}
