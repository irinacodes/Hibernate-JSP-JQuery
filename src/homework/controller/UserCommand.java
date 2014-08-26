package homework.controller;

import homework.model.*;
import homework.util.*;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author ibranovic
 */
public class UserCommand implements Command {

    @Override
    public String execute(HttpServletRequest request) {

        String next;

        String userId = request.getParameter("id");
        String username = request.getParameter("username");
        String password = request.getParameter("pwd");
        String name = request.getParameter("ime");
        String surname = request.getParameter("prezime");
        String email = request.getParameter("email");

        String titleId = request.getParameter("zvanje");
        String yearOfStudy = request.getParameter("godstudija");
        String gpa = request.getParameter("prosek");
        String phone = request.getParameter("telefon");
        String[] departmentIds = request.getParameterValues("odsek");
        
        User logged = (User) request.getSession().getAttribute("korisnik");
        
        boolean registration = !Validate.exists(userId);
        
        User editable = new User();       
        if(!registration)
           editable = HibernateUtil.load(User.class, userId);
           
        //samo telefon moze biti prazan - provera parametara na serverskoj strani
        boolean validParams = Validate.exists(username) && Validate.exists(password)
                && Validate.exists(name) && Validate.exists(surname)
                && Validate.exists(email) && Validate.isInteger(titleId);
        
        boolean validDemonstrator = departmentIds != null && Validate.isDouble(gpa) 
                && Validate.isInteger(yearOfStudy);
        
        Title title = null;
        if(Validate.isInteger(titleId))
          title = HibernateUtil.load(Title.class, titleId);
        
        boolean proceed = (validParams && !title.isDemonstrator()) || 
                (validParams && title.isDemonstrator() && validDemonstrator);
        
        if (proceed) {
            if(registration) {
                //nov editable - proveri da li username vec postoji
                if (User.findByUsername(username) != null) {
                    CommandsUtils.attachI18nMessage(request,"USERNAME_EXISTING");
                    return new EditUserCommand().execute(request);
                }
            }            
            editable.setUsername(username);
            editable.setPassword(DigestUtils.sha1Hex(password));
            editable.setName(name);
            editable.setSurname(surname);
            editable.setTitle(title);
            editable.setEmail(email);
            editable.setAdmin(false);
            if(validDemonstrator) {
                editable.setYearOfStudy(Integer.valueOf(yearOfStudy));
                editable.setGpa(Double.valueOf(gpa));
                editable.clearDepartments();
                for(String departmentId : departmentIds)
                  editable.addDepartment(departmentId);
            }
            
            if(Validate.exists(phone))
              editable.setPhone(phone);

            //ako korisnika unosi admin, on je odmah aktivan, inače nije           
            if (!registration && logged.isAdmin())
                editable.setActive(true);
                      
            HibernateUtil.saveOrUpdate(editable);
            
            if(registration) {
                CommandsUtils.attachI18nMessage(request,"REGISTRATION_SUCCESS");
                next = "index";
            } else {
                next = CommandsUtils.homePageSwitch(logged, request);
            }
        } else {
            CommandsUtils.attachI18nMessage(request,"ENTER_ALL");
            return new EditUserCommand().execute(request);
        }
        return next;
    }
}
